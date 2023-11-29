//
//  FavoritesView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    Image(systemName: "plus")
                }
                .frame(width: 250)
                
                Text("Favorites").bold()
            }
            .offset(x: -130, y: -310)
            
            Text("No Favorites")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    FavoritesView()
}
