//
//  Tab.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case favorites = "Favorites"
    case recents = "Recents"
    case all = "Contacts"
    case keypad = "Keypad"
    case voicemail = "Voicemail"
    
    var systemImage: String {
        switch self {
        case .favorites:
            return "star"
        case .recents:
            return "clock"
        case .all:
            return "person.circle"
        case .keypad:
            return "circle.grid.3x3.fill"
        case .voicemail:
            return "recordingtape"
            
        }
    }
}
