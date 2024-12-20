//
//  EmailAdresses.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 23/11/2024.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}
