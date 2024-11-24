//
//  UserDetail.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 21/11/2024.
//

import SwiftUI

struct UserDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var user: User
    
    var body: some View {
//        HStack {
//            Spacer()
//            Button {
//                idEditPage = project.id
//                showingEditPage = true
//            } label: {
//                Label("Edit project (WIP)", systemImage: "document.badge.gearshape")
//            }
//            .padding(20)
//        }
        
        
        VStack(alignment: .leading) {
            HStack() {
                Text("User Id : \(user.id)")
                    .padding(.top, 10)
                    .padding(.leading, 10)
                Spacer()
            }
            HStack {
                Text("User email : \(user.email)")
                    .padding(.top, 10)
                    .padding(.leading, 10)
                Spacer()
            }
            VStack (alignment: .leading){
                Text("User roles :")
                    .padding(.top, 10)
                    .padding(.leading, 10)
        
                ForEach(user.roles, id: \.self) { role in
                    Text(role)
                        .padding(.leading, 10)
                }
            }
            
            Button {
                Task {
                    await viewModel.deleteUser(id: user.id)
                    await viewModel.getUsers()
                    
                    dismiss()
                }
            } label: {
                Label("Delete user", systemImage: "trash")
            }
            .padding(.top, 10)
            .padding(.leading, 10)
            
            Spacer()
        }
    }
}
