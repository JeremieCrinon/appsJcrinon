//
//  users:new.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 23/11/2024.
//

import Foundation

struct usersNewResponse: Decodable {
    let status: String?
}

struct usersNewRequest: Encodable {
    let email: String
    let roles: Set<String>
}
