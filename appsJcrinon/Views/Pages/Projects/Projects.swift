//
//  Projects.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 31/10/2024.
//

import SwiftUI

struct Projects: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var showingCreatePage = false
    
    var body: some View {
        if viewModel.projects != nil {
            VStack {
                ProjectCreateButton(showingCreatePage: $showingCreatePage)
                
                ProjectList(projects: viewModel.projects!)
                    .sheet(isPresented: $showingCreatePage) {
                        ProjectCreate(showingCreatePage: $showingCreatePage)
                    }
            }
        } else {
            ErrorPage()
        }
    }
}

#Preview {
    Projects()
}
