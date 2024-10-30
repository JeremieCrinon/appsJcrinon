//
//  BurgerButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 05/10/2024.
//

import SwiftUI

struct BurgerButton: View {
    var body: some View {
        VStack {
            BurgerBar()
            BurgerBar()
                .offset(y: -235)
            BurgerBar()
                .offset(y: -470)
        }
    }
}

#Preview {
    BurgerButton()
}
