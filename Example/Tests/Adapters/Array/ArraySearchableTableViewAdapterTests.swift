//
//  ArraySearchableTableViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import XCTest
import Fakery
@testable import UIAdapterKit

class ArraySearchableTableViewAdapterTests: XCTestCase {
    private var faker: Faker!
    private var models: [BasicModel]!
    private var section: BMTableViewSection!
    private var adapter: ArraySearchableTableViewAdapter!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        models = BasicModel.fake(3)
        section = BMTableViewSection(items: models, itemBuilder: { BasicTableViewItem($0) })
        adapter = ArraySearchableTableViewAdapter()
    }
    
    func testHasItems() {
        let ex = self.expectation(description: name)
        
        XCTAssertFalse(adapter.hasItems)
        
        adapter.append(section: section)
        XCTAssertTrue(adapter.hasItems)
        
        adapter.filter(with: faker.lorem.word(), completion: {
            ex.fulfill()
        })
        wait(for: [ex], timeout: 10)
        
        XCTAssertEqual(adapter.hasItems, adapter.filteredItemsCount > 0)
    }
    
    func testSectionCount() {
        let ex = self.expectation(description: name)
        
        XCTAssertEqual(adapter.sectionCount, 0)
        
        adapter.append(section: section)
        XCTAssertEqual(adapter.sectionCount, 1)
        
        adapter.filter(with: faker.lorem.paragraphs()) {
            ex.fulfill()
        }
        wait(for: [ex], timeout: 10)
        
        XCTAssertEqual(adapter.sectionCount, 1)
        XCTAssertEqual(adapter.section(for: 0)!.count, 0)
    }
    
    func testFilter() {
        XCTAssertFalse(adapter.isSeeking)
        XCTAssertNil(adapter.filterPayload)
        
        adapter.append(section: section)
        adapter.append(section: section)
        
        let exFoundSomething = self.expectation(description: "\(name).FoundSomething")
        adapter.filter(with: models.first!.text) {
            exFoundSomething.fulfill()
        }
        wait(for: [exFoundSomething], timeout: 10)
        
        XCTAssertEqual(adapter.sectionCount, 2)
        XCTAssertEqual(adapter.section(for: 0)!.count, 1)
        XCTAssertEqual(adapter.section(for: 1)!.count, 1)
        XCTAssertTrue(adapter.hasItems)
        XCTAssertEqual(adapter.filteredItemsCount, 2)
        XCTAssertTrue(adapter.isSeeking)
        XCTAssertNotNil(adapter.filterPayload)
        
        adapter.filter(with: nil)
        XCTAssertFalse(adapter.isSeeking)
        XCTAssertNil(adapter.filterPayload)
        
        let exNoFound = self.expectation(description: "\(name).NoFound")
        adapter.filter(with: faker.lorem.paragraphs()) {
            exNoFound.fulfill()
        }
        wait(for: [exNoFound], timeout: 10)
        
        XCTAssertEqual(adapter.sectionCount, 2)
        XCTAssertEqual(adapter.section(for: 0)!.count, 0)
        XCTAssertEqual(adapter.section(for: 1)!.count, 0)
        XCTAssertFalse(adapter.hasItems)
        XCTAssertEqual(adapter.filteredItemsCount, 0)
        XCTAssertTrue(adapter.isSeeking)
        XCTAssertNotNil(adapter.filterPayload)
    }
}

fileprivate class BMTableViewSection: ArrayTableViewSection<BasicModel> {
    override func filter(item: BasicModel, with payload: Any) -> Bool {
        if let string = payload as? String {
            return item.text.contains(string) ||
                item.detail.contains(string)
        }
        
        return super.filter(item: item, with: payload)
    }
}

#endif
