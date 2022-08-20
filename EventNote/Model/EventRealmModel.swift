//
//  EventRealmModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.08.2022.
//

import RealmSwift

class EventRealmModel: Object {
    
    @Persisted var kindOfShooting: String = ""
    @Persisted var dateAndTime = Date()
    @Persisted var amountOfHours: Int = 0
    
    @Persisted var customerName: String = ""
    @Persisted var customerPhoneNumber: Int = 0
    @Persisted var additionalPhoneNumber: Int = 0
    @Persisted var customerTelegramOrChat: String = ""
    @Persisted var customerInstagram: String = ""
    
    @Persisted var mainLocation: String = ""
    @Persisted var startLocation: String = ""
    @Persisted var endLocation: String = ""
    
    @Persisted var priceForHour: Int = 0
    @Persisted var fullPrice: Int = 0
    @Persisted var prepayment: Int = 0
    
    @Persisted var alertString: String = ""

}
