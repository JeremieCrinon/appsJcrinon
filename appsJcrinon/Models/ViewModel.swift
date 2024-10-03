//
//  ProjectsViewModel.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 06/10/2024.
//

import SwiftUI
import Foundation

class ProjectsViewModel: ObservableObject {
    @Published var projects: [Project] = [] // Shared projects array
    @Published var isLoading: Bool = true // Track loading state
    
    init() {
        Task {
            await loadProjects()
        }
    }
    
    func loadProjects() async {
        let url = URL(string: "https://api.jcrinon.com/api/projects")!
        if let fetchedProjects: [Project] = await fetchAPI(url) {
            DispatchQueue.main.async {
                self.projects = fetchedProjects
                self.isLoading = false
            }
        } else {
            print("Failed to load projects")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func loadFiveSecs() {
        self.isLoading = true
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.isLoading = false
        }
    }
}

//func fetchAPI<T: Decodable>(_ url: URL) async -> T? {
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        print("Failed to fetch or decode API data from \(url):\n\(error)")
//        return nil
//    }
//}
