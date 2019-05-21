//
//  Models.swift
//  RealmDB-Manager
//
//  Created by Abdelhak Jemaii on 02.04.19.
//  Copyright © 2019 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import RealmSwift

class Mapper: Object {
    @objc dynamic var id: Int = -1
    var things = List<Thing>()
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Thing: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var pos: Int = -1
    @objc dynamic var type: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
