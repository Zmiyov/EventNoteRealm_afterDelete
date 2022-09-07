//
//  DeadlinesList.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import Foundation

enum DeadlinesList: CaseIterable, CustomStringConvertible {
    case none
    case inADay
    case inAWeek
    case inATwoWeeks
    case inAMonth
    case inATwoMonths
    case inAThreeMonths
    case inAFourMonths
    case inAFiveMonths
    case inASixMonths
    
    var description: String {
        switch self {
        case .none:
            return "None"
        case .inADay:
            return "In a day"
        case .inAWeek:
            return "In a week"
        case .inATwoWeeks:
            return "In a two weeks"
        case .inAMonth:
            return "In a month"
        case .inATwoMonths:
            return "In a two months"
        case .inAThreeMonths:
            return "In a three months"
        case .inAFourMonths:
            return "In a four months"
        case .inAFiveMonths:
            return "In a five months"
        case .inASixMonths:
            return "In a six months"
        }
    }
}
