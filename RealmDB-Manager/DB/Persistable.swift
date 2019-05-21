//
//  Persistable.swift
//  CouchDBDemo
//
//  Created by Abdelhak Jemaii on 19.10.18.
//  Copyright © 2018 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import RealmSwift

typealias CodableObject = Object

protocol Persister {
    static func select<T: CodableObject>(type: T.Type, filter: NSPredicate?) -> Results<T>
    static func insert(object: CodableObject, update: Bool?)
    static func insert(objects: [CodableObject], update: Bool?)
    static func delete(object: CodableObject)
    static func delete<T: CodableObject>(type: T.Type, filter: NSPredicate?)
    static func deleteAll<T: CodableObject>(type: T.Type)
    static func resetDB()
}

extension Persister {
    
    // MARK: - Read Methods
    static func select<T: CodableObject>(type: T.Type, filter: NSPredicate? = nil) -> Results<T>  {
        do {
            let realm = try Realm()
            if let predicate = filter {
                return realm.objects(T.self).filter(predicate)
            } else {
                return realm.objects(T.self)
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    
    // MARK: - Write methods
    static func insert(object: CodableObject, update: Bool? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                if let update = update {
                    realm.add(object, update: update)
                } else {
                    realm.add(object)
                }
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    static func insert(objects: [CodableObject], update: Bool? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                if let update = update {
                    realm.add(objects, update: update)
                } else {
                    realm.add(objects)
                }
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    static func delete(object: CodableObject) {
        // Delete an object with a transaction
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    static func delete<T: CodableObject>(type: T.Type, filter: NSPredicate?) {
        do {
            let realm = try Realm()
            try realm.write {
                if let predicate = filter {
                    realm.delete(realm.objects(T.self).filter(predicate))
                } else {
                    realm.delete(realm.objects(T.self))
                }
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    static func resetDB() {
        // Delete an object with a transaction
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
    
    static func deleteAll<T: CodableObject>(type: T.Type) {
        // Delete an object with a transaction
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(T.self))
            }
        }  catch let error as NSError {
            fatalError("Error opening Realm: \(error)")
        }
    }
}
