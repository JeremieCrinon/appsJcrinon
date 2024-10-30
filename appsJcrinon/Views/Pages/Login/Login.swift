//
//  Login.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 09/10/2024.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSuccessfull: Bool = true // If it's false, it means the last time was unsuccessfull, so we inform the user that he made a mistake
    
    var body: some View {
        VStack {
            Text("Login")
            Spacer()
            Form {
                Group {
                    if !isSuccessfull {
                        Text("The credentials you provided are not correct.")
                            .foregroundStyle(Color("ErrorColor"))
                    }
                }
                
                Group {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                Group {
                    Button(action: {
                        Task {
                            isSuccessfull = await viewModel.connect(email: email, password: password)
                        }
                    }) {
                        Text("Log in")
                            .foregroundStyle(Color("MainColor"))
                    }
                }
            
            }
            
        }
    }
}

#Preview {
    Login()
}
