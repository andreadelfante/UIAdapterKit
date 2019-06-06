//
//  SectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

class SectionTests: XCTestCase {
    
    private var section: BasicSection!
    
    override func setUp() {
        super.setUp()
        
        section = BasicSection(items: BasicModel.fake(30).map { _ in BasicItem() },
                               nibForHeader: UINib(nibName: "Header", bundle: nil),
                               nibForFooter: UINib(nibName: "Footer", bundle: nil))
    }
    
    func testCount() {
        XCTAssertEqual(section.count, 30)
    }
    
    func testIsEmpty() {
        XCTAssertFalse(section.isEmpty)
    }
    
    func testItemForIndex() {
        XCTAssertNil(section.item(for: -1))
        XCTAssertNotNil(section.item(for: 0))
        XCTAssertNil(section.item(for: 100))
    }
    
    func testReuseIdentifierForHeader() {
        XCTAssertEqual(section.reuseIdentifierForHeader, "BasicSection.Header")
    }
    
    func testReuseIdentifierForFooter() {
        XCTAssertEqual(section.reuseIdentifierForFooter, "BasicSection.Footer")
    }
    
    func testNibForHeader() {
        XCTAssertNotNil(section.nibForHeader)
    }
    
    func testNibForFooter() {
        XCTAssertNotNil(section.nibForFooter)
    }
}
