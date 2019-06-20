//
//  RealmSearchableTableViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 20/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import Fakery
@testable import UIAdapterKit

class RealmSearchableTableViewAdapterTests: BaseRealmTestCase {
    private var adapter: RealmSearchableTableViewAdapter!
    private var faker: Faker!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        
        let results = realm.objects(BasicModel.self)
        adapter = RealmSearchableTableViewAdapter(animation: .row(.automatic))
            .map(section: RealmFilterableTableViewSection(results: results, itemBuilder: { BasicTableViewItem($0) }))
    }
    
    func testRowAnimation() {
        XCTAssertEqual(adapter.rowAnimation, .row(.automatic))
        
        adapter.filterPayload = faker.lorem.word()
        XCTAssertEqual(adapter.rowAnimation, .none)
    }
    
    func testHasItems() {
        XCTAssertTrue(adapter.hasItems)
        
        adapter.filterPayload = faker.lorem.paragraphs()
        XCTAssertFalse(adapter.hasItems)
    }
    
    func testSectionCount() {
        XCTAssertEqual(adapter.sectionCount, 1)
        
        adapter.filterPayload = faker.lorem.paragraphs()
        XCTAssertEqual(adapter.sectionCount, 1)
    }
    
    func testSectionForIndex() {
        XCTAssertNotNil(adapter.section(for: 0))
        
        adapter.filterPayload = faker.lorem.paragraphs()
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNil(adapter.section(for: adapter.sectionCount))
        XCTAssertNotNil(adapter.section(for: 0))
    }
    
    func testFilterPayload() {
        XCTAssertEqual(adapter.filteredItemsCount, 0)
        XCTAssertFalse(adapter.isSeeking)
        XCTAssertTrue(adapter.filteredSections.isEmpty)
        
        adapter.filterPayload = faker.lorem.paragraphs()
        XCTAssertNotEqual(adapter.filteredItemsCount, adapter.itemsCount)
        XCTAssertTrue(adapter.isSeeking)
        XCTAssertFalse(adapter.filteredSections.isEmpty)
        //XCTAssertFalse(adapter.filteredSections == adapter.sections)
        
        adapter.filterPayload = nil
        XCTAssertEqual(adapter.filteredItemsCount, 0)
        XCTAssertFalse(adapter.isSeeking)
        XCTAssertTrue(adapter.filteredSections.isEmpty)
    }
}

class RealmFilterableTableViewSection: RealmTableViewSection<BasicModel>, RealmFilterableSection {
    func filter(with payload: Any) -> NSPredicate? {
        return NSPredicate(format: "text CONTAINS[c] %@", payload as! String)
    }
}
