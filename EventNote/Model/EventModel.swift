//
//  EventModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 11.09.2022.
//

import Foundation

class EventModel {
    
    var kindOfShooting: String?
    var dateAndTime: Date = Date()
    var deadlineDate: Date?
    var deadlineString: String?
    var amountOfHours: Int = 0
    
    var clientName: String?
    var clientPhoneNumber: String?
    var additionalPhoneNumber: String?
    var clientTelegramOrChat: String?
    var clientInstagram: String?
    
    var mainLocation: String?
    var startLocation: String?
    var endLocation: String?
    
    var priceForHour: String?
    var fullPrice: String?
    var prepayment: String?
    
    var alertString: String?
    var alertDate: Date?
    
    var isDone: Bool = false
    var identifierID: String?

}
