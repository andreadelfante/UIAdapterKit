//
//  StaticCollectionViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import XCTest
@testable import UIAdapterKit

class StaticCollectionViewAdapterTests: XCTestCase {
    
    private var models: [BasicModel]!
    private var items: [BasicCollectionViewItem]!
    
    override func setUp() {
        super.setUp()
        
        models = BasicModel.fake(30)
        items = models.map { BasicCollectionViewItem($0) }
    }
    
    func testSectionCount() {
        let adapter = StaticCollectionViewAdapter(sections: [
            StaticCollectionViewSection(items: items)
        ])
        
        XCTAssertEqual(1, adapter.sectionCount)
    }
    
    func testHasSection() {
        let adapter = StaticCollectionViewAdapter(sections: [
            StaticCollectionViewSection(items: items)
        ])
        
        XCTAssertTrue(adapter.hasSections)
    }
    
    func testSectionForIndex() {
        let adapter = StaticCollectionViewAdapter(sections: [
            StaticCollectionViewSection(items: items)
        ])
        
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNotNil(adapter.section(for: 0))
    }
    
    func testSectionForItem() {
        let adapter = StaticCollectionViewAdapter(sections: [
            StaticCollectionViewSection(items: items)
        ])
        
        XCTAssertNil(adapter.section(for: -1)?.item(for: -1))
        XCTAssertNil(adapter.section(for: -1)?.item(for: 0))
        XCTAssertNil(adapter.section(for: 0)?.item(for: -1))
        XCTAssertNotNil(adapter.section(for: 0)?.item(for: 0))
    }
}

#endif
