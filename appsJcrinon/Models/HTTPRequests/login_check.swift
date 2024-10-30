//
//  login_check.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 09/10/2024.
//

import Foundation

struct Login_checkResponse: Decodable {
    let token: String?
}

struct Login_checkRequest: Encodable {
    let email: String
    let password: String
}
