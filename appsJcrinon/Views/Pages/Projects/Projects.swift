//
//  Projects.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 31/10/2024.
//

import SwiftUI

struct Projects: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ProjectList(projects: viewModel.projects!)
    }
}

#Preview {
    Projects()
}
