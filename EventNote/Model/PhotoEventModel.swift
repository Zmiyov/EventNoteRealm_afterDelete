//
//  PhotoEventModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 13.08.2022.
//

import Foundation
import UIKit

struct Event {
    var kindOfShooting: String
    var customerName: String
    //    var dateAndTime: Date
    //    var amountOfHours: Int
    
    var customerPhoneNumber: Int
    var additionalPhoneNumber: Int?
    var customerTelegramOrChat: String?
    var customerInstagram: String?
    
    var mainLocation: String
    var startLocation: String?
    var endLocation: String?

    var priceForHour: Int?
    var fullPrice: Int
    var prepayment: Int?
    
    var alert: Date?

//    var notes: String?
    //    var customerPhoto: UIImage?
}
