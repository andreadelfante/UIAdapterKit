//
//  RealmTableViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
@testable import UIAdapterKit

class RealmTableViewAdapterTests: BaseRealmTestCase {
    private var adapter: RealmTableViewAdapter!
    
    override func setUp() {
        super.setUp()
        
        adapter = RealmTableViewAdapter()
            .map(section: RealmTableViewSection(results: realm.objects(BasicModel.self), itemBuilder: { BasicTableViewItem($0) }))
    }
    
    func testSectionCount() {
        XCTAssertEqual(adapter.sectionCount, 1)
    }
    
    func testSectionForIndex() {
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNotNil(adapter.section(for: 0))
    }
    
    func testHasItems() {
        XCTAssertEqual(adapter.hasItems, true)
    }
    
    func testDeleteIndex() {
        adapter.delete(index: 0)
        XCTAssertEqual(adapter.sectionCount, 0)
    }
}
