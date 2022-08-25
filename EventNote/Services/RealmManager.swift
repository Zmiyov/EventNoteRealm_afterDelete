//
//  RealmManager.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.08.2022.
//

import RealmSwift
import Realm

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
   
    func saveEventModel(model: EventRealmModel) {
        try! localRealm.write {
            localRealm.add(model)
//            print("User Realm User file location: \(localRealm.configuration.fileURL!.path)")
        }
    }
    
    func deleteEventModel(model: EventRealmModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
}
