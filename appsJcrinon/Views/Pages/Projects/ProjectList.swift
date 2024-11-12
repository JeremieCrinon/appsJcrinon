//
//  ProjectList.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI

struct ProjectList: View {
    var projects: [Project]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(projects) { project in
                    NavigationLink {
                        ProjectDetail(project: project)
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
