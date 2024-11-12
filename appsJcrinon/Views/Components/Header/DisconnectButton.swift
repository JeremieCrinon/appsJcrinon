//
//  DisconnectButton.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 12/11/2024.
//

import SwiftUI

struct DisconnectButton: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Button(action: {
            viewModel.disconnect()
        }) {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(20)
        }
    }
}
