//
//  ProjectList.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI

struct ProjectList: View {
    @Binding var showingCreatePage: Bool
    
    @Binding var idEditPage: Int?
    @Binding var showingEditPage: Bool
    
    var projects: [Project]
    
    var body: some View {
        NavigationSplitView {
            ProjectCreateButton(showingCreatePage: $showingCreatePage)
            List {
                ForEach(projects) { project in
                    NavigationLink {
                        ProjectDetail(project: project, idEditPage: $idEditPage, showingEditPage: $showingEditPage)
                    } label: {
                        ProjectRow(project: project)
                    }
                    
                }
            }
        } detail: {
            Text("Projects")
        }
        
    }
}
