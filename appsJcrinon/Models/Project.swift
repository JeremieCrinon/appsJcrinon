//
//  Project.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import Foundation

struct Project: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let french_name: String
    let french_description: String
    let github_link: String?
    let project_link: String?
    let image: String?
}
