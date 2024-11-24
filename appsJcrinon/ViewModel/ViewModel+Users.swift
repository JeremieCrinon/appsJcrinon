//
//  ViewModel+Users.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 17/11/2024.
//

import Foundation
import SwiftUI

extension ViewModel {
    func getUsers() async -> Void {
        
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
//                self.errorMessage = "There has been an error getting the token in the keychain."
                self.disconnect()
            }
            return
        }
        
//        print("token = \(token)")
        
        let url = URL(string: "\(config.apiBaseUrl)/api/users/")!
        
        if let response: [User] = await APIWithoutBodyWithJWT(url: url, token: token, viewModel: self){
            DispatchQueue.main.async {
                self.users = response
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the users list."
            }
            return
        }
        
        if(self.clientErrorCode != nil) { // In case the server returned a client error
            self.clientErrorCode = nil // We can reset the error now that we handle it
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the users list."
            }
            return
        }
        
        let url2 = URL(string: "\(config.apiBaseUrl)/api/users/roles")!
        
        if let response: [String] = await APIWithoutBodyWithJWT(url: url2, token: token, viewModel: self) {
            DispatchQueue.main.async {
                self.possibleRoles = response
            }
        }
            
        else {
           DispatchQueue.main.async {
               self.errorMessage = "There has been an error getting the users list."
           }
           return
       }
       
       if(self.clientErrorCode != nil) { // In case the server returned a client error
           self.clientErrorCode = nil // We can reset the error now that we handle it
           DispatchQueue.main.async {
               self.errorMessage = "There has been an error getting the users list."
           }
           return
       }
    }
    
    func createUser(email: String, roles: Set<String>) async -> String?{
        
        // Verifications
        if email.isEmpty {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please enter an email for the new user"
        }
        
        if !isValidEmail(email){
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please enter a valid email for the new user"
        }
       
        if self.users!.contains(where: { user in
            return user.email.caseInsensitiveCompare(email) == .orderedSame
        }) {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "A user with this email adress already exists"
        }
        
        if roles.isEmpty {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return "Please choose at least one role. You can choose ROLE_USER if you don't want the user to have any special permissions"
        }
        
        // Sending request
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
                self.disconnect()
                self.isLoading = false
            }
            return "Error getting the token, try reconnecting" // This message should never be seen cause the error page should be displayed, but in case the error page displays, it is good having an error message
        }
        
        let body = usersNewRequest(email: email, roles: roles)
        let url = URL(string: "\(config.apiBaseUrl)/api/users/new")!
        
        if let _: usersNewResponse = await APIWithBodyWithJWT(url: url, body: body, token: token, viewModel: self){
            if(self.clientErrorCode != nil) { // In case the server returned a client error
                DispatchQueue.main.async {
                    self.clientErrorCode = nil // We have handeled the error, now we can put it back to nil
                    self.isLoading = false
                }
                return "There has been an error creating the user, please try again later"
            }
        } else {
            return "There has been an error creating the user, please try again later"
        }
        
        
        DispatchQueue.main.async {
            self.isLoading = false
            
        }
        
        return nil
    }
    
    func deleteUser(id: Int) async -> Void{
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
                self.disconnect()
                self.isLoading = false
            }
            return
        }
        
        let url = URL(string: "\(config.apiBaseUrl)/api/users/\(id)/delete")!
        
//        let response = await
        if let response: usersDeleteResponse = await APIWithoutBodyWithJWT(url: url, token: token, viewModel: self){
            
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error deleting the user."
            }
            return
        }
        
        if(self.clientErrorCode != nil) { // In case the server returned a client error
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error deleting the user."
            }
            return
        }
        
        return
    }
}
