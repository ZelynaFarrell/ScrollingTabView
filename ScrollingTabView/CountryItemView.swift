//
//  CountryItemView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/18/23.
//

import SwiftUI

struct CountryItemView: View {
    let country: CountryModel

//    init(countryModel: CountryModel, selected: Bool) {
//        self.countryModel = countryModel
//    }
    
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

//#Preview {
//    ContentView()
//}
