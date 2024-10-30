//
//  MenuRow.swift
//  appsJcrinon
//
//  Created by Jeremie Crinon on 03/10/2024.
//

import SwiftUI

struct MenuRow: View {
    var page: Page
    
    var body: some View {
        HStack {
            page.symbol
                .resizable()
                .frame(width: 50, height: 50)
            Text(page.title)
            
            Spacer()
        }
    }
}

#Preview {
    MenuRow(page: pages[0])
}
