//
//  ContactItem.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import SwiftUI

struct ContactItem: View {
    let country: Country
    
    var body: some View {
        VStack {
                Text("\(country.name)\("(")\(country.dial_code)\(")")")
                    .font(Font.system(size: 15))
                    .foregroundStyle(.primary)
                    .fontWeight(.light)
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Divider()
        }
        .padding(.horizontal, 19)
    }
}
