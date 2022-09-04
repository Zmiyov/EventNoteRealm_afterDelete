//
//  EventRealmModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.08.2022.
//

import RealmSwift
import Foundation

class EventRealmModel: Object {
    
    @Persisted var kindOfShooting: String = ""
    @Persisted var dateAndTime: Date = Date()
    @Persisted var amountOfHours: Int = 0
    
    @Persisted var clientName: String = ""
    @Persisted var clientPhoneNumber: String = ""
    @Persisted var additionalPhoneNumber: String = ""
    @Persisted var clientTelegramOrChat: String = ""
    @Persisted var clientInstagram: String = ""
    
    @Persisted var mainLocation: String = ""
    @Persisted var startLocation: String = ""
    @Persisted var endLocation: String = ""
    
    @Persisted var priceForHour: String = ""
    @Persisted var fullPrice: String = ""
    @Persisted var prepayment: String = ""
    
    @Persisted var alertString: String = ""
    @Persisted var alertDate: Date?
    
    @Persisted var identifierID: String = UUID().uuidString

}
