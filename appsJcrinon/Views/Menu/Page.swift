//
//  Page.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import Foundation
import SwiftUI

struct Page {
    var id: Int
    var title: String
    
    private var symbolName: String
    var symbol: Image {
        Image(systemName: symbolName)
    }
    
    
}
