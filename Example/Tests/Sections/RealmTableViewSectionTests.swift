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
                                        results: realm.objects(BasicModel.self),
                                        itemBuilder: { BasicTableViewItem($0) })
    }
    
    func testHeaderTitle() {
        XCTAssertNotNil(section.headerTitle)
    }
    
    func testFooterTitle() {
        XCTAssertNotNil(section.footerTitle)
    }
    
    func testCount() {
        XCTAssertEqual(section.count, realm.objects(BasicModel.self).count)
    }
    
    func testItemForIndex() {
        XCTAssertNil(section.item(for: -1))
        XCTAssertNotNil(section.item(for: 0))
    }
    
    func testNibForHeader() {
        XCTAssertNil(section.nibForHeader)
    }
    
    func testNibForFooter() {
        XCTAssertNil(section.nibForFooter)
    }
}
