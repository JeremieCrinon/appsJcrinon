//
//  UserList.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 21/11/2024.
//

import SwiftUI

struct UserList: View {
    @Binding var showingCreatePage: Bool
    
    var users: [User]
    
    var body: some View {
        NavigationSplitView {
            UserCreateButton(showingCreatePage: $showingCreatePage)
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetail(user: user)
                    } label: {
                        UserRow(user: user)
                    }
                    
                }
            }
        } detail: {
            Text("Users")
        }
        
    }
    
}
