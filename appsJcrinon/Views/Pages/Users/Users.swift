//
//  Users.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 21/11/2024.
//

import SwiftUI

struct Users: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var showingCreatePage: Bool = false
    
    var body: some View {
        if viewModel.users != nil {
            UserList(showingCreatePage: $showingCreatePage, users: viewModel.users!)
                .sheet(isPresented: $showingCreatePage) {
                    UserCreate(showingCreatePage: $showingCreatePage)
                }
        }
    }
}

#Preview {
    Users()
}
