//
//  StaticTableViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import XCTest
@testable import UIAdapterKit

class StaticTableViewAdapterTests: XCTestCase {
    
    private var tableView: UITableView!
    private var models: [BasicModel]!
    private var items: [BasicTableViewItem]!
    
    override func setUp() {
        super.setUp()
        
        tableView = UITableView()
        models = BasicModel.fake(30)
        items = models.map { BasicTableViewItem($0) }
    }
    
    func testSectionCount() {
        let adapter = StaticTableViewAdapter(sections: [
            StaticTableViewSection(items: items)
        ])
        
        XCTAssertEqual(1, adapter.sectionCount)
    }
    
    func testHasSections() {
        let adapter = StaticTableViewAdapter(sections: [
            StaticTableViewSection(items: items)
        ])
        
        XCTAssertTrue(adapter.hasSections)
    }
    
    func testSectionForIndex() {
        let adapter = StaticTableViewAdapter(sections: [
            StaticTableViewSection(items: items)
        ])
        
        XCTAssertNil(adapter.section(for: -1))
        XCTAssertNotNil(adapter.section(for: 0))
    }
    
    func testSectionForItem() {
        let adapter = StaticTableViewAdapter(sections: [
            StaticTableViewSection(items: items)
        ])
        
        XCTAssertNil(adapter.section(for: -1)?.item(for: -1))
        XCTAssertNil(adapter.section(for: -1)?.item(for: 0))
        XCTAssertNil(adapter.section(for: 0)?.item(for: -1))
        XCTAssertNotNil(adapter.section(for: 0)?.item(for: 0))
    }
}

#endif
