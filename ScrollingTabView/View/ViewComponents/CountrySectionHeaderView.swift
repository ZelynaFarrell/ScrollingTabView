//
//  CountrySectionHeaderView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/18/23.
//

import SwiftUI

struct ContactsSectionHeaderView: View {
    let text: String
    
    var body: some View {
        Rectangle()
            .fill(.headerBackground)
            .overlay(alignment: .leading) {
                Text(text)
                    .font(Font.system(size: 18))
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .padding(17)
            }
            .frame(height: 35)
    }
}

#Preview {
    ContactsSectionHeaderView(text: "A")
}
