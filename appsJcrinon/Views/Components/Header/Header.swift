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
                DisconnectButton()
            }
            
            HStack(alignment: .center){
                Text("Jcrinon.com")
                    .frame(alignment: .center)
                    .font(.title2)
                    .bold()
            }
            
        }
        
    }
}

//#Preview {
//    Header()
//}
