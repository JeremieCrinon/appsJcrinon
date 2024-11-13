//
//  MenuList.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import SwiftUI

struct MenuList: View {
    @Binding var selectedPage: Page? // Binding to track the selected page
    @Binding var isMenuOpen: Bool // Binding to control the menu visibility
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationSplitView {
            List(pages) { page in
                if viewModel.getUserRoles().contains(page.role) || viewModel.getUserRoles().contains("ROLE_ADMIN"){
                    Button(action: {
                        selectedPage = page
                        isMenuOpen = false // Close the menu after selection
                    }) {
                        MenuRow(page: page)
                    }
                }
                
            }
        } detail: {
            Text("Select a page")
        }
    }
}

#Preview {
    MenuList(selectedPage: .constant(pages.first), isMenuOpen: .constant(true))
        .environmentObject(ViewModel())
}
