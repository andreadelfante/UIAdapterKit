//
//  ArrayCollectionViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

class ArrayCollectionViewAdapterTests: XCTestCase {
    private var section: ArrayCollectionViewSection<BasicModel>!
    private var anotherSection: ArrayCollectionViewSection<BasicModel>!
    private var adapter: ArrayCollectionViewAdapter!
    
    override func setUp() {
        super.setUp()
        
        section = ArrayCollectionViewSection(items: BasicModel.fake(3), itemBuilder: { BasicCollectionViewItem($0) })
        anotherSection = ArrayCollectionViewSection(items: BasicModel.fake(2), itemBuilder: { BasicCollectionViewItem($0) })
        adapter = ArrayCollectionViewAdapter()
    }
    
    func testSectionCount() {
        XCTAssertEqual(adapter.sectionCount, 0)
        
        adapter.append(section: section)
        XCTAssertEqual(adapter.sectionCount, 1)
    }
    
    func testSectionAtIndex() {
        adapter.append(section: section)
        
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNotNil(adapter.section(for: 0))
        XCTAssertNil(adapter.section(for: adapter.sectionCount))
    }
    
    func testAppend() {
        XCTAssertFalse(adapter.hasSections)
        XCTAssertNil(adapter.section(for: 0))
        
        adapter.append(section: section)
        XCTAssertNotNil(adapter.section(for: 0))
        XCTAssertTrue(adapter.hasSections)
        XCTAssertEqual(adapter.itemsCount, section.count * adapter.sectionCount)
    }
    
    func testInsert() {
        XCTAssertFalse(adapter.hasSections)
        
        XCTAssertTrue(adapter.insert(section: section, at: 0))
        XCTAssertTrue(adapter.insert(section: section, at: 0))
        XCTAssertTrue(adapter.insert(section: section, at: 2))
        XCTAssertFalse(adapter.insert(section: section, at: -1))
        XCTAssertFalse(adapter.insert(section: section, at: 100))
        
        XCTAssertTrue(adapter.hasSections)
        XCTAssertEqual(adapter.itemsCount, section.count * adapter.sectionCount)
    }
    
    func testReplace() {
        XCTAssertFalse(adapter.hasSections)
        
        adapter.append(section: section)
        XCTAssertTrue(adapter.replace(section: anotherSection, at: 0))
        XCTAssertEqual(adapter.sectionCount, 1)
        XCTAssertEqual(adapter.itemsCount, anotherSection.count)
        
        XCTAssertFalse(adapter.replace(section: section, at: -1))
        XCTAssertFalse(adapter.replace(section: section, at: 100))
        XCTAssertEqual(adapter.itemsCount, anotherSection.count)
    }
    
    func testRemoveAtIndex() {
        XCTAssertFalse(adapter.remove(at: 0))
        
        adapter.append(section: section)
        XCTAssertEqual(adapter.sectionCount, 1)
        XCTAssertTrue(adapter.remove(at: 0))
        XCTAssertEqual(adapter.sectionCount, 0)
        
        XCTAssertFalse(adapter.remove(at: -1))
        XCTAssertFalse(adapter.remove(at: 100))
    }
    
    func testRemoveAll() {
        adapter.append(section: section)
        adapter.append(section: anotherSection)
        XCTAssertEqual(adapter.sectionCount, 2)
        
        adapter.removeAll()
        XCTAssertEqual(adapter.sectionCount, 0)
    }
    
    func testHasItems() {
        XCTAssertFalse(adapter.hasItems)
        
        adapter.append(section: section)
        XCTAssertTrue(adapter.hasItems)
    }
}
