//
//  Header.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 06/10/2024.
//

import SwiftUI

struct Header: View {
    @Binding var isMenuOpen: Bool
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            
            HStack {
                MenuButton(isMenuOpen: $isMenuOpen)
                Spacer()
                Button(action: {
                    viewModel.disconnect()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(20)
                        .foregroundStyle(Color("MainColor"))
                }
            }
            
            HStack(alignment: .center){
                Text("Jcrinon.com") // élément qui doit être centré
                    .frame(alignment: .center)
                    .font(.title)
                    .bold()
            }
            
        }
        
    }
}

//#Preview {
//    Header()
//}
