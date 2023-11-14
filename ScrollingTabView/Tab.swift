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
    case voicemail = "Voicemail"
    
    var systemImage: String {
        switch self {
        case .recents:
            return "clock"
        case .favorites:
            return "star"
        case .voicemail:
            return "phone"
        }
    }
}
