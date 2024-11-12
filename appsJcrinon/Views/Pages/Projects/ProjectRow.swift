//
//  ProjectRow.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 11/11/2024.
//

import SwiftUI

struct ProjectRow: View {
    var project: Project
    
    var body: some View {
        Text(project.name)
    }
}
