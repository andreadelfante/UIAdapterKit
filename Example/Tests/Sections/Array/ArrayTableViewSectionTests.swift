//
//  ArrayTableViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

class ArrayTableViewSectionTests: XCTestCase {
    private var models: [BasicModel]!
    private var section: ArrayTableViewSection<BasicModel>!
    
    override func setUp() {
        super.setUp()
        
        models = BasicModel.fake(7)
        section = ArrayTableViewSection(
            items: models,
            itemBuilder: { BasicTableViewItem($0) }
        )
    }
    
    func testCount() {
        XCTAssertEqual(section.count, models.count)
    }
    
    func testItemForIndex() {
        XCTAssertNil(section.item(for: -1))
        XCTAssertNotNil(section.item(for: 0))
        XCTAssertNotNil(section.item(for: section.count - 1))
        XCTAssertNil(section.item(for: section.count))
    }
}
