//
//  ProjectCreateButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 12/11/2024.
//

import SwiftUI

struct ProjectCreateButton: View {
    @Binding var showingCreatePage: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                showingCreatePage.toggle()
            } label: {
                Label("Create project", systemImage: "document.badge.plus")
            }
            .padding(20)
        }
    }
}
