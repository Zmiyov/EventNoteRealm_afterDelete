//
//  PhotoEventModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 13.08.2022.
//

import Foundation
import UIKit

struct PhotoEvent {
    var customerName: String
    var customerPhoto: UIImage?
    var customerPhoneNumber: Int
    var kindOfShooting: String
    var dateAndTime: Date
    var location: String
    var price: Int
    var amountOfHours: Int
    var prepayment: Int?
    var notes: String?
    
}
