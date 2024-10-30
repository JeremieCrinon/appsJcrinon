//
//  Test.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import SwiftUI

struct Test: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        
    }
}

#Preview {
    Test()
        .environmentObject(ViewModel())
}
