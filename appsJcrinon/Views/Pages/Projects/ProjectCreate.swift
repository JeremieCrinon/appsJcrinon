//
//  ProjectCreate.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI

struct ProjectCreate: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Text("Hello, World!")
        
        Button {
            print(viewModel.getUserRoles())
        } label: {
            Label("Create project", systemImage: "document.badge.plus")
        }
    }
}

#Preview {
    ProjectCreate()
        .environmentObject(ViewModel())
}
