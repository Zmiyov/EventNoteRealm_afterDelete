//
//  KindOfShootingList.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 18.08.2022.
//

import Foundation

enum KindOfShootingList: CaseIterable, CustomStringConvertible {
    case wedding
    case portrait
    case reportage
    case pregnant
    case birthday
    case family
    case loveStory
    
    var description: String {
        switch self {
        case .wedding:
            return "Wedding"
        case .portrait:
            return "Portrait"
        case .reportage:
            return "Reportage"
        case .pregnant:
            return "Pregnant"
        case .birthday:
            return "Birthday"
        case .family:
            return "Family"
        case .loveStory:
            return "Love Story"
        }
    }
}

