//
//  ProjectCreate.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI
import PhotosUI

struct ProjectCreate: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var showingCreatePage: Bool
    
    @State private var userError: String? = nil
    
    @State private var name: String = ""
    @State private var fr_name: String = ""
    @State private var description: String = ""
    @State private var fr_description: String = ""
    @State private var github: String = ""
    @State private var link: String = ""
    
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        VStack {
            Text("Create new project")
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
                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                    
                    PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Select an Image", systemImage: "photo")
                    }
                    .onChange(of: selectedImage) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                self.imageData = data
                            }
                        }
                    }
                }
                
                Group {
                    Button(action: {
                        Task {
                            userError = await viewModel.createProject(name: name, description: description, french_name: fr_name, french_description: fr_description, github_link: github, project_link: link, image: imageData)
                            
                            if userError == nil {
                                await viewModel.getProjects() // To reload the projects and have the new one displayed
                                showingCreatePage = false
                            } else {
                                showingCreatePage = true
                            }
                        }
                    }) {
                        Text("Create project")
                    }
                }
            
            }
            
        }
        
    }
}

#Preview {
//    ProjectCreate()
//        .environmentObject(ViewModel())
}
