//
//  ViewModel.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 06/10/2024.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var isConnected: Bool = false
    
    @Published var errorMessage: String? = nil
    @Published var clientErrorCode: Int? = nil
    
    @Published var userRoles: Array<String>? = ["ROLE_USER"]
    
    @Published var projects: Array<Project>? = nil
    @Published var users: Array<User>? = nil
    
    @Published var possibleRoles: Array<String>? = nil
    
    let keychain = KeychainSwift()
    
    init() {
        Task {
            await verifyConnexion()
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
