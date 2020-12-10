//
//  StaticCollectionViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import XCTest
import Fakery
@testable import UIAdapterKit

class StaticCollectionViewSectionTests: XCTestCase {
    private var section: StaticCollectionViewSection!
    
    override func setUp() {
        super.setUp()
        
        section = StaticCollectionViewSection(items: BasicModel.fake(7).map { BasicCollectionViewItem($0) })
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

#endif
