//
//  UserCreateButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 21/11/2024.
//

import SwiftUI

struct UserCreateButton: View {
    @Binding var showingCreatePage: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                showingCreatePage = true
            } label: {
                Label("Create user", systemImage: "document.badge.plus")
            }
            .padding(20)
        }
    }
}
