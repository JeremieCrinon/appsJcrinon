//
//  UserRow.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 21/11/2024.
//

import SwiftUI

struct UserRow: View {
    var user: User
    
    var body: some View {
        Text(user.email)
    }
}
