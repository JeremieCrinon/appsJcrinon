//
//  ContentView.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel() // Initialize the view model
    
    @State private var selectedPage: Page? = pages.first // Start with the first page
//    @State private var selectedPage: Page? = pages[2] // Temporary, to start on another page so we don't have to navigate to the page at each reload
    @State private var isMenuOpen = false // Control the visibility of the menu
    
    var body: some View {
        VStack() {
            if viewModel.errorMessage != nil {
                ErrorPage()
            } else if !NetworkMonitor.shared.isConnected {
                OfflinePage()
            } else if viewModel.isLoading {
                LoadingPage()
            } else if !viewModel.isConnected {
                Login()
            } else if viewModel.userRoles == nil || viewModel.userRoles!.contains("NEW_ACCOUNT") {
                FinishAccountPage()
            } else if viewModel.userRoles == nil || viewModel.userRoles!.contains("UNVERIFIED_EMAIL") {
                FinishAccountPage() // This is the same page has for NEW_ACCOUNT, but we don't make a single condition cause it will be different later
            } else if isMenuOpen {
                MenuList(selectedPage: $selectedPage, isMenuOpen: $isMenuOpen)
            } else { // If the user is connected, and everything is ok
                Header(isMenuOpen: $isMenuOpen)
                
//                Button {
//                    print(selectedPage)
//                } label: {
//                    Label("Print selected page", systemImage: "document.badge.plus")
//                }
                
                // Show the currently selected page
                if let page = selectedPage {
                    page.view // Display the current page's view
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .environmentObject(viewModel) // Make viewModel accessible to child views
    }

}

#Preview {
    ContentView()
}
