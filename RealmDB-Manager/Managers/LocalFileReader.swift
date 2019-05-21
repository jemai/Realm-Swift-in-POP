//
//  LocalFileReader.swift
//  endiosOne-iOS
//
//  Created by Abdelhak Jemaii on 15.10.18.
//  Copyright © 2018 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import RealmSwift

/*
 *                        // MARK: - <#LocalFileReader Protocol#>
 *
 * This protocol is responsible for reading all local files that contains a Codable object data
 *
 */ 

public enum FileType: String {
    case text = "txt"
    case json
    case html
    case pdf
}

protocol LocalFileReader {
    static func loadLocalData<T: Codable>(to type: T.Type,
                                          fileName: String,
                                          fileType: FileType,
                                          completion: (T?, NSError?) -> Void)
    
    static func loadLocalData<T: Object>(to type: T.Type,
                                         fileName: String,
                                         fileType: FileType)
}

extension LocalFileReader {
    static func loadLocalData<T: Codable>(to type: T.Type,
                                          fileName: String,
                                          fileType: FileType,
                                          completion: (T?, NSError?) -> Void) {
        if let filepath = Bundle.main.path(forResource: fileName,
                                           ofType: fileType.rawValue) {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let response = try? JSONDecoder().decode(T.self, from: jsonData)
                completion(response, nil)
            } catch {
                completion(nil, NSError.init(domain: "Somthing went wrong", code: 0, userInfo: nil))
            }
        }
    }
    
    static func loadLocalData<T: Object>(to type: T.Type,
                                         fileName: String,
                                         fileType: FileType) {
        if let filepath = Bundle.main.path(forResource: fileName,
                                           ofType: fileType.rawValue) {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let json = try! JSONSerialization.jsonObject(with: jsonData, options: [])
                let realm = try Realm()
                try realm.write {
                    realm.create(T.self, value: json, update: true)
                }
            } catch let error {
                print("Somthing went wrong \(error)")
            }
        }
    }
}
