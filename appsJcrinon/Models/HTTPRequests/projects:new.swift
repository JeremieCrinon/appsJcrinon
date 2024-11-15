//
//  projects:new.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 14/11/2024.
//

import Foundation

struct projectsNewResponse: Decodable {
    let status: String?
}

struct projectsNewRequest: Encodable {
    let name: String
    let french_name: String
    let description: String
    let french_description: String
    let github_link: String?
    let project_link: String?
    let image: Data
}
