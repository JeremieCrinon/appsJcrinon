//
//  ViewModel.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 06/10/2024.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
//    @Published var projects: [Project] = [] // Shared projects array
    @Published var isLoading: Bool = true // Track loading state
    @Published var isConnected: Bool = false
    
    @Published var errorMessage: String? = nil
    @Published var clientErrorCode: Int? = nil
    
    @Published var userRoles: Array<String>? = nil
    
    
    let keychain = KeychainSwift()
    
    init() {
        Task {
            await verifyConnexion()
            print("\(config.apiBaseUrl)/api/isuser")
        }
    }
    
    func verifyConnexion() async -> Void {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let token = keychain.get("APIToken") else {
            DispatchQueue.main.async {
                self.isConnected = false
                self.isLoading = false
            }
            return
        }
        
        let url = URL(string: "\(config.apiBaseUrl)/api/isuser")!
        
        
        
        if let response: IsUser = await APIWithoutBodyWithJWT(url: url, token: token, viewModel: self) {
            DispatchQueue.main.async {
                if(response.result == nil) {
                    self.isConnected = false
                    self.disconnect() // So we don't make the verification every time
                    self.isLoading = false
                    return
                } else {
                    self.userRoles = response.roles
                }
            }
            
        }
        
        
        
        
        if(self.clientErrorCode != nil) { // In case the server returned a client error
            DispatchQueue.main.async {
                self.clientErrorCode = nil // We have handeled the error, now we can put it back to nil
                self.isConnected = false
                self.disconnect() // So we do not make the verification every time
                self.isLoading = false
            }
            
            return
        }
        
        DispatchQueue.main.async {
            self.isConnected = true
            self.isLoading = false
        }
        
        return
        
    }
    
    func connect(email: String, password: String) async -> Bool {
        
        let body = Login_checkRequest(email: email, password: password)
        let url = URL(string: "\(config.apiBaseUrl)/api/login_check")!
        
        if let response: Login_checkResponse = await APIWithBodyWithoutJWT(url: url, body: body, viewModel: self) {

            if(response.token == nil) {
                DispatchQueue.main.async {
                    self.isConnected = false
                    self.isLoading = false
                }
                return false
            } else if(self.clientErrorCode != nil) { // In case the server returned a client error
                DispatchQueue.main.async {
                    self.clientErrorCode = nil // We have handeled the error, now we can put it back to nil
                    self.isConnected = false
                    self.isLoading = false
                }
                return false
            } else {
                keychain.set(response.token!, forKey: "APIToken")
                
                await self.verifyConnexion() // To be sure the token is valid, and have the user roles set
            }
        } else {
            DispatchQueue.main.async {
                self.isConnected = false
                self.isLoading = false
            }
            return false
        }
        
        DispatchQueue.main.async {
            self.isConnected = true
            self.isLoading = false
        }
        
        return true
    }
    
    func disconnect() {
        keychain.delete("APIToken")
        DispatchQueue.main.async {
            self.isConnected = false
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    
    func clientError(code: Int) {
        DispatchQueue.main.async {
            self.clientErrorCode = code
        }
    }
}