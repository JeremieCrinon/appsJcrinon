//
//  UserCreate.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 23/11/2024.
//

import SwiftUI

struct UserCreate: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var showingCreatePage: Bool
    
    @State private var userError: String? = nil
    
    @State private var email: String = ""
    @State private var roles: Set<String> = []
    
    var body: some View {
        VStack {
            Text("Create new user")
                .font(.title)
                .bold()
                .padding(.top, 25)
            
            Form {
                Group {
                    if userError != nil {
                        Text(userError!)
                            .foregroundStyle(Color("ErrorColor"))
                    }
                }
                
                Group {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                    
                    if let rolesList = viewModel.possibleRoles {
                        
                        List(rolesList, id: \.self) { role in
                            MultipleSelectionRow(title: role, isSelected: roles.contains(role)) {
                                if roles.contains(role) {
                                    roles.remove(role)
                                } else {
                                    roles.insert(role)
                                }
                            }
                        }
                        
                    }
                }
                
                Group {
                    Button(action: {
                        Task {
                            userError = await viewModel.createUser(email: email, roles: roles)
                            
                            
                            if userError == nil {
                                await viewModel.getUsers() // To reload the users and have the new one displayed
                                showingCreatePage = false
                            } else {
                                showingCreatePage = true
                            }
                        }
                    }) {
                        Text("Create user")
                    }
                }
            
            }
            
        }
    }
}
