//
//  RealmCollectionViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
@testable import UIAdapterKit
#if SWIFT_PACKAGE
@testable import UIAdapterKit_Realm
#endif

class RealmCollectionViewAdapterTests: BaseRealmTestCase {
    private var adapter: RealmCollectionViewAdapter!
    private var section: CustomRealmCollectionViewSection!
    
    override func setUp() {
        super.setUp()
        
        section = CustomRealmCollectionViewSection(results: realm.objects(BasicModel.self), itemBuilder: { BasicCollectionViewItem($0) })
        adapter = RealmCollectionViewAdapter().map(section: section)
    }
    
    func testSectionCount() {
        XCTAssertEqual(adapter.sectionCount, 1)
    }
    
    func testSectionForIndex() {
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNotNil(adapter.section(for: 0))
    }
    
    func testHasItems() {
        XCTAssertTrue(adapter.hasItems)
    }
    
    func testDeleteIndex() {
        adapter.delete(index: 0)
        XCTAssertEqual(adapter.sectionCount, 0)
        XCTAssertEqual(adapter.itemsCount, 0)
    }
    
    func testDeleteAll() {
        adapter.deleteAll()
        XCTAssertEqual(adapter.sectionCount, 0)
        XCTAssertEqual(adapter.itemsCount, 0)
    }
    
    func testOnInitial() {
        var preInitial = false
        var postInitial = false
        
        let ex = expectation(description: name)
        ex.expectedFulfillmentCount = 2
        
        section.preInitial = {
            preInitial = true
            XCTAssertFalse(postInitial)
            ex.fulfill()
        }
        section.postInitial = {
            postInitial = true
            XCTAssertTrue(preInitial)
            ex.fulfill()
        }
        
        wait(for: [ex], timeout: 3)
    }
    
    func testOnUpdate() {
        var preUpdate = false
        var postUpdate = false
        
        let ex = expectation(description: name)
        ex.expectedFulfillmentCount = 2
        
        section.preUpdate = {
            preUpdate = true
            XCTAssertFalse(postUpdate)
            ex.fulfill()
        }
        section.postUpdate = {
            postUpdate = true
            XCTAssertTrue(preUpdate)
            ex.fulfill()
        }
        
        try! realm.write {
            realm.add(BasicModel.fake(), update: .all)
        }
        
        wait(for: [ex], timeout: 3)
    }
}

class CustomRealmCollectionViewSection: RealmCollectionViewSection<BasicModel> {
    var preInitial: (() -> Void)?
    var postInitial: (() -> Void)?
    var preUpdate: (() -> Void)?
    var postUpdate: (() -> Void)?
    
    override func onPreInitial() {
        preInitial?()
    }
    
    override func onPostInitial() {
        postInitial?()
    }
    
    override func onPreUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {
        preUpdate?()
    }
    
    override func onPostUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {
        postUpdate?()
    }
}
