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

class RealmCollectionViewAdapterTests: BaseRealmTestCase {
    private var adapter: RealmCollectionViewAdapter!
    
    override func setUp() {
        super.setUp()
        
        adapter = RealmCollectionViewAdapter()
            .map(section: RealmCollectionViewSection(results: realm.objects(BasicModel.self), itemBuilder: { BasicCollectionViewItem($0) }))
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
}
