//
//  ProjectEdit.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 17/11/2024.
//

import SwiftUI

struct ProjectEdit: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var showingEditPage: Bool
    @Binding var projectId: Int?
    
    @State private var userError: String? = nil
    
    private var project: Project? {
        guard let id = projectId else { return nil }
        return viewModel.projects?.first(where: { $0.id == id })
    }
    
    @State private var name: String = ""
    @State private var fr_name: String = ""
    @State private var description: String = ""
    @State private var fr_description: String = ""
    @State private var github: String = ""
    @State private var link: String = ""
    
    var body: some View {
        VStack {
            Text("Edit \(project!.name)")
                .font(.title)
                .bold()
                .padding(.top, 25)
            
            Form {
                Group {
                    if userError != nil {
                        Text(userError!)
                            .foregroundStyle(Color("ErrorColor"))
                    }
                }
                
                Group {
                    TextField("Name", text: $name)
                    TextField("French name", text: $fr_name)
                    TextField("Description", text: $description)
                    TextField("French description", text: $fr_description)
                    TextField("Link of the github repository (facultative)", text: $github)
                    TextField("Link of the project (facultative)", text: $link)
                    
                }
                
                Group {
//                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 200)
//                            .cornerRadius(10)
//                    }
                    
//                    PhotosPicker(
//                        selection: $selectedImage,
//                        matching: .images,
//                        photoLibrary: .shared()
//                    ) {
//                        Label("Select an Image", systemImage: "photo")
//                    }
//                    .onChange(of: selectedImage) { newItem in
//                        Task {
//                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                                self.imageData = data
//                            }
//                        }
//                    }
                }
                
                Group {
                    Button(action: {
                        Task {
                            userError = await viewModel.editProject(id: projectId!, name: name, description: description, french_name: fr_name, french_description: fr_description, github_link: github, project_link: link, image: nil)
                            
                            if userError == nil {
                                await viewModel.getProjects() // To reload the projects and have the edited one displayed
                                showingEditPage = false
                            } else {
                                showingEditPage = true
                            }
                        }
                    }) {
                        Text("Edit \(project!.name)")
                    }
                }
            
            }
            
        }
        .onAppear {
            // Initialise project inputs
            if let project = project {
                name = project.name
                fr_name = project.french_name
                description = project.description
                fr_description = project.french_description
                github = project.github_link ?? ""
                link = project.project_link ?? ""
            }
        }
    }
}
