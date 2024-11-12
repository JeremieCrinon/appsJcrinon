//
//  Home.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 31/10/2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Text("Hi!")
                .font(.title)
            Text("This is your dashboard, for now, it's a bit empty, but a lot of things are gonna be here in the future.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 10)
            Spacer()
        }
        .padding(.top, 50)
        
    }
}

#Preview {
    Home()
}
