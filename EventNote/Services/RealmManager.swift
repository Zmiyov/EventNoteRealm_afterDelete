//
//  RealmManager.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.08.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveEventModel(model: EventRealmModel) {
        try! localRealm.write {
            localRealm.add(model )
        }
    }
    

    
}
