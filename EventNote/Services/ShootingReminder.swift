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
        
        print("Date in schedule", date)
        
        let dateOfTrigger = Calendar.current.date(byAdding: .second, value: 1, to: date)!
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfTrigger)
        
        let timeIntervalTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: timeIntervalTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func unschedule() {
        
    }
    
//    private func authorizeIfNeeded(completion: @escaping (Bool) -> ()) {
//
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                completion(true)
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.sound, .alert]) { granted, _ in
//                    completion(granted)
//                }
//            case .denied, .provisional, .ephemeral:
//                completion(false)
//            @unknown default:
//                completion(false)
//            }
//        }
//    }
}

