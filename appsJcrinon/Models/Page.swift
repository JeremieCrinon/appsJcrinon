//
//  Page.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import Foundation
import SwiftUI

struct Page: Codable, Identifiable {
    var id: Int
    var title: String
    var role: String
    
    private var symbolName: String
    var symbol: Image {
        Image(systemName: symbolName)
    }
    
    var viewName: String // Add viewName field to match the JSON

    // A computed property to return the appropriate view based on the viewName
    var view: AnyView {
        switch viewName {
        case "Home":
            return AnyView(Home())
        case "Projects":
            return AnyView(Projects())
        default:
            return AnyView(ErrorPage()) // Default case for error handling
        }
    }
}
