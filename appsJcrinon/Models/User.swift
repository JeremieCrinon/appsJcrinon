//
//  User.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 17/11/2024.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int
    let email: String
    let roles: [String]
}
