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
        if let projects = viewModel.projects {
            VStack {
                ProjectCreateButton(showingCreatePage: $showingCreatePage)
                
                ProjectList(projects: viewModel.projects!)
                    .sheet(isPresented: $showingCreatePage) {
                        ProjectCreate()
                    }
            }
        } else {
//            ErrorPage()
            Button(action: {
                print(viewModel.projects)
            }) {
                Image(systemName: "line.3.horizontal.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(20)
            }
        }
    }
}

#Preview {
    Projects()
}
