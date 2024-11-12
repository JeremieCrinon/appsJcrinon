//
//  MenuButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 06/10/2024.
//

import SwiftUI

struct MenuButton: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isMenuOpen.toggle()
            }
        }) {
            Image(systemName: "line.3.horizontal.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(20)
        }
    }
}

//#Preview {
//    MenuButton()
//}
