//
//  ViewModel+Projects.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 01/11/2024.
//

import Foundation
import SwiftUI

extension ViewModel {
    func getProjects() async -> Void { // This function is called by the verifyConnexion() of ViewModel+Login
        
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the token in the keychain."
                self.disconnect()
            }
            return
        }
        
        let url = URL(string: "\(config.apiBaseUrl)/api/projects/get")!
        
        if let response: [Project] = await APIWithoutBodyWithJWT(url: url, token: token, viewModel: self){
            DispatchQueue.main.async {
                self.projects = response
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the projects list."
            }
            return
        }
        
        if(self.clientErrorCode != nil) { // In case the server returned a client error
            DispatchQueue.main.async {
                self.errorMessage = "There has been an error getting the projects list."
            }
            return
        }
        
        
//        print(self.projects)
        
    }
}
