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
                .font(.title)
                .bold()
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
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                }
                
                Group {
                    Button(action: {
                        Task {
                            isSuccessfull = await viewModel.connect(email: email, password: password)
                        }
                    }) {
                        Text("Log in")
                    }
                }
            
            }
            
        }
    }
}

#Preview {
    Login()
}
