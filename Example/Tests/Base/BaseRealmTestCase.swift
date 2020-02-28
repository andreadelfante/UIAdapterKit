//
//  BaseRealmTestCase.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift

class BaseRealmTestCase: XCTestCase {
    var realm: Realm!
    
    override func setUp() {
        super.setUp()
        
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: name))
        try! realm.write {
            realm.add(BasicModel.fake(30), update: .all)
        }
    }
    
    override func tearDown() {
        realm = nil
        
        super.tearDown()
    }
}
