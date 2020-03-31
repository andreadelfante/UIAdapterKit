//
//  RealmTableViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import Fakery
@testable import UIAdapterKit

class RealmTableViewSectionTests: BaseRealmTestCase {
    private var section: RealmTableViewSection<BasicModel>!
    private var faker: Faker!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        section = RealmTableViewSection(headerTitle: faker.lorem.word(),
                                        footerTitle: faker.lorem.word(),
                                        headerHeight: 1,
                                        footerHeight: 2,
                                        results: realm.objects(BasicModel.self),
                                        itemBuilder: { BasicTableViewItem($0) })
    }
    
    func testTitleForHeader() {
        XCTAssertEqual(section.titleForHeader, section.headerTitle)
    }
    
    func testTitleForFooter() {
        XCTAssertEqual(section.titleForFooter, section.footerTitle)
    }
    
    func testCount() {
        XCTAssertEqual(section.count, realm.objects(BasicModel.self).count)
    }
    
    func testItemForIndex() {
        XCTAssertNil(section.item(for: -1))
        XCTAssertNotNil(section.item(for: 0))
    }
    
    func testHeaderHeight() {
        let height = section.heightForHeader(UITableView())
        
        XCTAssertNotNil(height)
        XCTAssertEqual(height, 1)
    }
    
    func testFooterHeight() {
        let height = section.heightForFooter(UITableView())
        
        XCTAssertNotNil(height)
        XCTAssertEqual(height, 2)
    }
}
