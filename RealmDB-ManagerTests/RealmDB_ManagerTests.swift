//
//  RealmDB_ManagerTests.swift
//  RealmDB-ManagerTests
//
//  Created by Abdelhak Jemaii on 02.04.19.
//  Copyright © 2019 Abdelhak Jemaii. All rights reserved.
//

import XCTest
@testable import RealmDB_Manager
@testable import RealmSwift
@testable import Realm

class RealmDB_ManagerTests: XCTestCase {
    
    struct service: LocalFileReader { }
    struct db: Persister { }
    var things = [Thing]()
    
    override func setUp() {
        service.loadLocalData(to: Mapper.self, fileName: "data", fileType: .json)
        things = Array(db.select(type: Thing.self))
    }
    
    override func tearDown() {
        db.resetDB()
    }
    
    func testQuery() {
        assert(things.count == 3, "the count should be 3")
    }
    
    func testFilter() {
        let queryResult = db.select(type: Thing.self, filter: NSPredicate(format: "id == %d", 0))
        assert(queryResult.count == 1, "the count should be 1 since we are quering by id, and the id is activated in the object")
        let aThing = queryResult.first!
        assert(aThing.id == 0, "id should be the same as the filtered one")
    }
}
