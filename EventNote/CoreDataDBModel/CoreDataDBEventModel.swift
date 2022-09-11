//
//  CoreDataDBEventModel.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 10.09.2022.
//

import Foundation
import CoreData

class EventEntity: NSManagedObject {
    
    class func findOrCreate(event: EventModel, context: NSManagedObjectContext) throws -> EventEntity {

        let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest() as! NSFetchRequest<EventEntity>
        request.predicate = NSPredicate(format: "identifierID == %d", event.identifierID)
        
        do {
            let events = try context.fetch(request)
            if events.count > 0 {
                assert(events.count == 1, "There are few events ralated to one ID")
                return events[0]
            }
        } catch {
            throw error
        }
        
        let eventEntity = EventEntity(context: context)
        
        eventEntity.kindOfShooting = event.kindOfShooting
        eventEntity.dateAndTime = event.dateAndTime
        eventEntity.deadlineDate = event.deadlineDate
        eventEntity.deadlineString = event.deadlineString
        eventEntity.amountOfHours = Int16(event.amountOfHours)
        
        eventEntity.clientName = event.clientName
        eventEntity.clientPhoneNumber = event.clientPhoneNumber
        eventEntity.additionalPhoneNumber = event.additionalPhoneNumber
        eventEntity.clientTelegramOrChat = event.clientTelegramOrChat
        eventEntity.clientInstagram = event.clientInstagram
        
        eventEntity.mainLocation = event.mainLocation
        eventEntity.startLocation = event.startLocation
        eventEntity.endLocation = event.endLocation
        
        eventEntity.priceForHour = event.priceForHour
        eventEntity.fullPrice = event.fullPrice
        eventEntity.prepayment = event.prepayment
        
        eventEntity.alertString = event.alertString
        eventEntity.alertDate = event.alertDate
        
        eventEntity.isDone = event.isDone
        eventEntity.identifierID = event.identifierID
        
        return eventEntity
    }
    
}
