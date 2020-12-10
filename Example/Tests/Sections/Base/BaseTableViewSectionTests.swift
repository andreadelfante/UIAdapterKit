//
//  BaseTableViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import XCTest
import Fakery
@testable import UIAdapterKit

class BaseTableViewSectionTests: XCTestCase {
    private var faker: Faker!
    private var headerTitle: String!
    private var footerTitle: String!
    private var headerHeight: CGFloat!
    private var footerHeight: CGFloat!
    private var section: BaseTableViewSection!
    private var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        headerTitle = faker.lorem.words()
        footerTitle = faker.lorem.words()
        headerHeight = 10
        footerHeight = 20
        
        section = BaseTableViewSection(
            headerTitle: headerTitle,
            footerTitle: footerTitle,
            headerHeight: headerHeight,
            footerHeight: footerHeight
        )
        
        tableView = UITableView()
    }
    
    func testHeaderTitle() {
        XCTAssertEqual(section.headerTitle, headerTitle)
        XCTAssertEqual(section.titleForHeader, headerTitle)
    }
    
    func testFooterTitle() {
        XCTAssertEqual(section.footerTitle, footerTitle)
        XCTAssertEqual(section.titleForFooter, footerTitle)
    }
    
    func testHeaderHeight() {
        XCTAssertEqual(section.headerHeight, headerHeight)
        XCTAssertEqual(section.heightForHeader(tableView), headerHeight)
    }
    
    func testFooterHeight() {
        XCTAssertEqual(section.footerHeight, footerHeight)
        XCTAssertEqual(section.heightForFooter(tableView), footerHeight)
    }
    
    func testReuseIdentifierForHeader() {
        XCTAssertEqual(section.reuseIdentifierForHeader, "BaseTableViewSection.Header")
    }
    
    func testReuseIdentifierForFooter() {
        XCTAssertEqual(section.reuseIdentifierForFooter, "BaseTableViewSection.Footer")
    }
    
    func testCopy() {
        let copy = section.copy()
        
        XCTAssertEqual(copy.headerTitle, section.headerTitle)
        XCTAssertEqual(copy.footerTitle, section.footerTitle)
        XCTAssertEqual(copy.headerHeight, section.headerHeight)
        XCTAssertEqual(copy.footerHeight, section.footerHeight)
    }
}

#endif
