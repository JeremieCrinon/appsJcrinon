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
//        ZStack {
//            Color.clear
//
//            Button(action: {
//                withAnimation {
//                    isMenuOpen.toggle()
//                }
//            }) {
//                Image(systemName: "line.3.horizontal.circle")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .padding(20)
//            }
//        }
        HStack {
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Image(systemName: "line.3.horizontal.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(20)
            }
            Spacer()
        }
        
        
        
    }
}

//#Preview {
//    MenuButton()
//}
