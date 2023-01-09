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
    case deadline
    case amountOfHours
    
    var description: String {
        switch self {
        case .kindOfShooting:
            return "Kind of shooting"
        case .date:
            return "Date"
        case .deadline:
            return "Deadline"
        case .amountOfHours:
            return "Amount of Hours"
        }
    }
}

enum AddEventCellNameContactsSectionType: CaseIterable, CustomStringConvertible {
    
    case name
    case phone
    case telegram
    case instagram
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .phone:
            return "Phone"
        case .telegram:
            return "Telegram"
        case .instagram:
            return "Instagram"
        }
    }
}

enum AddEventCellLocationsMainSectionType: CaseIterable, CustomStringConvertible {
    
    case start
    
    var description: String {
        switch self {
        case .start:
            return "Start Location"
        }
    }
}

enum AddEventCellNamePaymentSectionType: CaseIterable, CustomStringConvertible {
    
    case fullPrice
    case prepayment
    case isCertificate
    
    var description: String {
        switch self {
        case .fullPrice:
            return "Full Price"
        case .prepayment:
            return "Prepayment"
        case .isCertificate:
            return "Certificate"
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

enum AddEventCellNameNotesSectionType: CaseIterable, CustomStringConvertible {
    
    case notes
    
    var description: String {
        switch self {
        case .notes:
            return "Notes"
        }
    }
}

