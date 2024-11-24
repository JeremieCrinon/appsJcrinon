//
//  Projects.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 31/10/2024.
//

import SwiftUI

struct Projects: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var showingCreatePage: Bool = false
    @State var showingEditPage: Bool = false
    @State var idEditPage: Int? = nil
    
    var body: some View {
        if viewModel.projects != nil {
            VStack {
                ProjectList(showingCreatePage: $showingCreatePage, idEditPage: $idEditPage, showingEditPage: $showingEditPage, projects: viewModel.projects!)
                    .sheet(isPresented: $showingCreatePage) {
                        ProjectCreate(showingCreatePage: $showingCreatePage)
                    }
                    .sheet(isPresented: $showingEditPage) {
                        ProjectEdit(showingEditPage: $showingEditPage, projectId: $idEditPage)
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
