//
//  OfflinePage.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 24/11/2024.
//

import SwiftUI

struct OfflinePage: View {
    var body: some View {
        VStack {
            Image(systemName: "network.slash")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color("ErrorColor"))
            
            
            
            Text("This app require an internet connection.")
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(30)
        }
    }
}

#Preview {
    OfflinePage()
}
