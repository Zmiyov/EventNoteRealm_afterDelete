//
//  KindOfAlertList.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 18.08.2022.
//

import Foundation

enum KindOfAlertList: CaseIterable, CustomStringConvertible {
    case none
    case atTimeOfEvent
    case fiveMinutesBefore
    case tenMinutesBefore
    case fifteenMinutesBefore
    case thirtyMinutesBefore
    case oneHourBefore
    case twoHourBefore
    case oneDayBefore
    case twoDaysBefore
    case oneWeekBefore
    
    var description: String {
        switch self {
        case .none:
            return "None"
        case .atTimeOfEvent:
            return "At time of event"
        case .fiveMinutesBefore:
            return "5 minutes before"
        case .tenMinutesBefore:
            return "10 minutes before"
        case .fifteenMinutesBefore:
            return "15 minutes before"
        case .thirtyMinutesBefore:
            return "30 minutes before"
        case .oneHourBefore:
            return "1 hour before"
        case .twoHourBefore:
            return "2 hours before"
        case .oneDayBefore:
            return "1 day before"
        case .twoDaysBefore:
            return "2 days before"
        case .oneWeekBefore:
            return "1 week before"
        }
    }
}
