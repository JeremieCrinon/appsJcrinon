//
//  LoadingPage.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 12/10/2024.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack {
            ProgressView("Loading...") // Loading indicator
                .controlSize(.large)
                .scaleEffect(1.2)
                .padding(30)
                
            Text("Please wait")
                .font(.title)
        }
    }
}

#Preview {
    LoadingPage()
}
