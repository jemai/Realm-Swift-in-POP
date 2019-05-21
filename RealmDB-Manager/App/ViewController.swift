//
//  ViewController.swift
//  RealmDB-Manager
//
//  Created by Abdelhak Jemaii on 02.04.19.
//  Copyright © 2019 Abdelhak Jemaii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct service: LocalFileReader { }
    struct db: Persister { }
    var things = [Thing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.loadLocalData(to: Mapper.self, fileName: "data", fileType: .json)
        things = Array(db.select(type: Thing.self))
        
        print(db.select(type: Thing.self, filter: NSPredicate(format: "id == %d", 0)))
    }
}



