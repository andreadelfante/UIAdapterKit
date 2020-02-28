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
    private var section: CustomRealmTableViewSection!
    private var faker: Faker!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        section = CustomRealmTableViewSection(headerTitle: faker.lorem.word(),
                                        footerTitle: faker.lorem.word(),
                                        headerHeight: 0.5,
                                        footerHeight: 0.7,
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
    
    func testHeaderHeight() {
        let height = section.heightForHeader(UITableView())
        
        XCTAssertNotNil(height)
        XCTAssert(0.5 <= height! && height! <= 0.51)
    }
    
    func testInitialize() {
        section.onPreInitial()
        section.onPostInitial()
    }
    
    func testUpdate() {
        section.onPreUpdate(deletions: [1,2,3], insertions: [2,3,4], modifications: [4,5,6])
        section.onPostUpdate(deletions: [1,2,3], insertions: [2,3,4], modifications: [4,5,6])
    }
    
    func testFooterHeight() {
        let height = section.heightForFooter(UITableView())
        
        XCTAssertNotNil(height)
        XCTAssert(0.7 <= height! && height! <= 0.71)
    }
    
    func testDidEndDisplayingHeader() {
        section.didEndDisplayingHeader()
    }
    
    func testDidEndDisplayingFooter() {
        section.didEndDisplayingFooter()
    }
}

class CustomRealmTableViewSection: RealmTableViewSection<BasicModel> {
    
    override func onPreUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {
        XCTAssertNotNil(deletions)
        XCTAssertNotNil(insertions)
        XCTAssertNotNil(modifications)
    }
    
    override func onPostUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {
        XCTAssertNotNil(deletions)
        XCTAssertNotNil(insertions)
        XCTAssertNotNil(modifications)
    }
}
