//
//  StaticTableViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

class StaticTableViewSectionTests: XCTestCase {
    private var section: StaticTableViewSection!
    
    override func setUp() {
        super.setUp()
        
        section = StaticTableViewSection(items: BasicModel.fake(7).map { BasicTableViewItem($0) })
    }
    
    func testCount() {
        XCTAssertEqual(section.count, 7)
    }
    
    func testItemForIndex() {
        XCTAssertNil(section.item(for: -1))
        XCTAssertNotNil(section.item(for: 0))
        XCTAssertNil(section.item(for: 7))
        XCTAssertNotNil(section.item(for: 6))
    }
}
