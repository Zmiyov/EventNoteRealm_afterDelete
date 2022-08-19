//
//  AddEventCellNameType.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 19.08.2022.
//

import Foundation

enum AddEventCellNameMainSectionType: CaseIterable, CustomStringConvertible {
    case kindOfShooting
    case date
    case amountOfHours
    
    var description: String {
        switch self {
        case .kindOfShooting:
            return "Kind of shooting"
        case .date:
            return "Date"
        case .amountOfHours:
            return "Amount of Hours"
        }
    }
}

enum AddEventCellNameContactsSectionType: CaseIterable, CustomStringConvertible {
    case name
    case phone
    case additionalPhone
    case telegram
    case instagram
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .phone:
            return "Phone"
        case .additionalPhone:
            return "Additional Phone"
        case .telegram:
            return "Telegram"
        case .instagram:
            return "Instagram"
        }
    }
}

enum AddEventCellLocationsMainSectionType: CaseIterable, CustomStringConvertible {
    
    case main
    case start
    case end
    
    var description: String {
        switch self {
        case .main:
            return "Main"
        case .start:
            return "Start"
        case .end:
            return "End"
        }
    }
}

enum AddEventCellNamePaymentSectionType: CaseIterable, CustomStringConvertible {
    
    case forHour
    case fullPrice
    case prepayment
    
    var description: String {
        switch self {
        case .forHour:
            return "For Hour"
        case .fullPrice:
            return "Full Price"
        case .prepayment:
            return "Prepayment"
        }
    }
}

enum AddEventCellNameReminderSectionType: CaseIterable, CustomStringConvertible {
    
    case alert
    
    var description: String {
        switch self {
        case .alert:
            return "Alert"
        }
    }
}

