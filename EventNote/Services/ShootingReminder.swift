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
    
    func schedule() {
        print("Schedule works")
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "Title"
        content.body = "Body"
        
        
//        let dateOfTrigger = Calendar.current.date(byAdding: .second, value: 5, to: Date())!
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfTrigger)
//
//        let timeIntervalTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Date", content: content, trigger: timeIntervalTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
            print("reminder added")
        }
        
        
        
        
        
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                print(<#T##items: Any...##Any#>)
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.sound, .alert, .badge]) { granted, _ in
//                    print(<#T##items: Any...##Any#>)
//                }
//            case .denied, .provisional, .ephemeral:
//                print(<#T##items: Any...##Any#>)
//            @unknown default:
//                print(<#T##items: Any...##Any#>)
//            }
//        }
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

