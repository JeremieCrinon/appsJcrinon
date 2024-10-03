//
//  Isuser.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 08/10/2024.
//

import Foundation

struct IsUser: Decodable {
    let result: Bool?
    let roles: Array<String>?
}
