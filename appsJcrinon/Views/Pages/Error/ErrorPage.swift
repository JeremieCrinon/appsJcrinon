//
//  ErrorPage.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 12/10/2024.
//

import SwiftUI

struct ErrorPage: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color("ErrorColor"))
            
            
            
            Text(viewModel.errorMessage ?? "An error occured, please try restarting the app, or try again later.") // It should be impossible to have viewModel.errorMessage being nil here, but in case it is, we display a standard error message
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(30)
        }
        
    }
}

#Preview {
    ErrorPage()
        .environmentObject(ViewModel())
}
