//
//  ProjectDetail.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI

struct ProjectDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var project: Project
    @Binding var idEditPage: Int?
    @Binding var showingEditPage: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                idEditPage = project.id
                showingEditPage = true
            } label: {
                Label("Edit project (WIP)", systemImage: "document.badge.gearshape")
            }
            .padding(20)
        }
        
        
        VStack(alignment: .leading) {
            HStack() {
                Text("Project Id : \(project.id)")
                    .padding(.top, 10)
            }
            HStack {
                Text("Project Name : \(project.name)")
                    .padding(.top, 10)
            }
            HStack {
                Text("Project french name : \(project.french_name)")
                    .padding(.top, 10)
            }
            HStack {
                Text("Project description : \(project.description)")
                    .padding(.top, 10)
            }
            HStack {
                Text("Project french description : \(project.french_description)")
                    .padding(.top, 10)
            }
            HStack {
                Text(project.github_link != nil ? "Project github link : \(project.github_link!)" : "Project github link : No link")
                    .padding(.top, 10)
            }
            HStack {
                Text(project.project_link != nil ? "Project link : \(project.project_link!)" : "Project link : No link")
                    .padding(.top, 10)
            }
            AsyncImage(url: URL(string: "\(config.apiBaseUrl)/api/projects/image/\(project.image!)")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                } else if phase.error != nil {
                    Text("Failed to load image")
                        .foregroundColor(.error)
                    
                } else {
                    ProgressView()
                }
            }
            
            Button {
                Task {
                    await viewModel.deleteProject(id: project.id)
                    await viewModel.getProjects()
                    
                    dismiss()
                }
            } label: {
                Label("Delete project", systemImage: "trash")
            }
            
            Spacer()
        }
    }
}
