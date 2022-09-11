//
//  CoreDataManager.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 11.09.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func getEvents(_ complitionHandler: @escaping ([EventModel]) -> Void) {
        
        let eventEntities = try? EventEntity.getAllEvents(context: AppDelegate().persistentContainer.viewContext)
        
        if let events = eventEntities, events.count > 0 {
            var returnedEvents: [EventModel] = []
            for eventEntity in events {
                let event = EventModel()
                
                event.kindOfShooting = eventEntity.kindOfShooting ?? ""
                
                event.dateAndTime = eventEntity.dateAndTime ?? Date()
                event.deadlineDate = eventEntity.deadlineDate
                event.deadlineString = eventEntity.deadlineString ?? ""
                event.amountOfHours = Int(eventEntity.amountOfHours)
                
                event.clientName = eventEntity.clientName ?? ""
                event.clientPhoneNumber = eventEntity.clientPhoneNumber ?? ""
                event.additionalPhoneNumber = eventEntity.additionalPhoneNumber ?? ""
                event.clientTelegramOrChat = eventEntity.clientTelegramOrChat ?? ""
                event.clientInstagram = eventEntity.clientInstagram ?? ""
                
                event.mainLocation = eventEntity.mainLocation ?? ""
                event.startLocation = eventEntity.startLocation ?? ""
                event.endLocation = eventEntity.endLocation ?? ""
                
                event.priceForHour = eventEntity.priceForHour ?? ""
                event.fullPrice = eventEntity.fullPrice ?? ""
                event.prepayment = eventEntity.prepayment ?? ""
                
                event.alertString = eventEntity.alertString ?? ""
                event.alertDate = eventEntity.alertDate
                
                event.isDone = eventEntity.isDone
                event.identifierID = eventEntity.identifierID ?? UUID().uuidString
                
                returnedEvents.append(event)
            }
            
            complitionHandler(returnedEvents)
        } else {
            
        }
    }
    
    
}
