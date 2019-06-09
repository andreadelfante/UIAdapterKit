//
//  RealmCollectionViewSection.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import Fakery
@testable import UIAdapterKit

class RealmCollectionViewSectionTests: BaseRealmTestCase {
    private var section: RealmCollectionViewSection<BasicModel>!
    private var container: MockContainer!
    
    override func setUp() {
        super.setUp()
        
        container = MockContainer(x: 0, y: 0, width: 0, height: 0)
        section = RealmCollectionViewSection(results: realm.objects(BasicModel.self), itemBuilder: { BasicCollectionViewItem($0) })
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
    
    func testSizeForHeader() {
        XCTAssertNil(section.sizeForHeader(container))
    }
    
    func testNibForFooter() {
        XCTAssertNil(section.nibForFooter)
    }
    
    func testSizeForFooter() {
        XCTAssertNil(section.sizeForFooter(container))
    }
    
    func testMinimumLineSpacing() {
        XCTAssertNil(section.minimumLineSpacing(container))
    }
    
    func testMinimumInteritemSpacing() {
        XCTAssertNil(section.minimumInteritemSpacing(container))
    }
}
