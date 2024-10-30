//
//  BurgerBar.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import SwiftUI

struct BurgerBar: View {
    var body: some View {
        let centerX: CGFloat = 0
        let centerY = centerX
        let width: CGFloat = 75
        let height: CGFloat = 15
        Path { path in
            path.move(to: CGPoint(x: centerX, y:centerY))
            path.addLine(to: CGPoint(x: centerX + width, y: centerY))
            path.addLine(to: CGPoint(x: centerX + width, y: centerY + height))
            path.addLine(to: CGPoint(x: centerX, y: centerY + height))
        }
        .fill(.black)
    }
}

#Preview {
    BurgerBar()
}
