//
//  EventModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 13.08.2022.
//

import Foundation
import UIKit

struct Event {
    var kindOfShooting: String
    var dateAndTime: Date?
    var amountOfHours: Int?
    
    var clientName: String
    var clientPhoneNumber: String
    var additionalPhoneNumber: String?
    var clientTelegramOrChat: String?
    var clientInstagram: String?
    
    var mainLocation: String
    var startLocation: String?
    var endLocation: String?
    
    var priceForHour: String?
    var fullPrice: String
    var prepayment: String?
    
    var alertString: String?
    
    //    var notes: String?
    //    var customerPhoto: UIImage?
}
