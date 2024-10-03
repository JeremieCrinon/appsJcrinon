//
//  BurgerButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import SwiftUI

struct BurgerButton: View {
    var body: some View {
        var centerX: CGFloat = 50
        var centerY: CGFloat = 50
        Path { path in
            path.move(to: CGPoint(x: centerX, y:centerY))
            path.addLine(to: CGPoint(x: centerX + 300, y: centerY))
            path.addLine(to: CGPoint(x: centerX + 300, y: centerY + 100))
            path.addLine(to: CGPoint(x: centerX, y: centerY + 100))
        }
        
    }
}

#Preview {
    BurgerButton()
}
