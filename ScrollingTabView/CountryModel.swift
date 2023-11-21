//
//  CountryModel.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/18/23.
//

import Foundation

struct CountryModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var dial_code: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dial_code
        case code
    }
}
