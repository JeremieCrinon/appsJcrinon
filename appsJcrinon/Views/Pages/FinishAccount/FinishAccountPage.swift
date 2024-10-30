//
//  FinishAccountPage.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 12/10/2024.
//

import SwiftUI

struct FinishAccountPage: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Text("Please finish the creation of your account on the website.")
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
}

#Preview {
    FinishAccountPage()
        .environmentObject(ViewModel())
}
