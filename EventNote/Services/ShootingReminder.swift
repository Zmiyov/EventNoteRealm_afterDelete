//
//  ShootingReminder.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 01.09.2022.
//

import Foundation
import UserNotifications

struct ShootingReminder {
    
    static let shared = ShootingReminder()
    
    func schedule(date: Date, title: String, body: String, identifier: String) {
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = title
        content.body = body
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let timeOfTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: timeOfTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

