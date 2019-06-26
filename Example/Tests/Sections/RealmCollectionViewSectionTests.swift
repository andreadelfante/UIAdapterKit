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
    
    private let headerSize = CGSize(width: 0.5, height: 0.5)
    private let footerSize = CGSize(width: 0.7, height: 0.7)
    private let minimumLineSpacing = CGFloat(0.2)
    private let minimumInteritemSpacing = CGFloat(0.3)
    
    override func setUp() {
        super.setUp()
        
        container = MockContainer(x: 0, y: 0, width: 0, height: 0)
        section = RealmCollectionViewSection(headerSize: headerSize,
                                             footerSize: footerSize,
                                             minimumLineSpacing: minimumLineSpacing,
                                             minimumInteritemSpacing: minimumInteritemSpacing,
                                             results: realm.objects(BasicModel.self),
                                             itemBuilder: { BasicCollectionViewItem($0) })
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
        XCTAssertEqual(section.sizeForHeader(container), headerSize)
    }
    
    func testNibForFooter() {
        XCTAssertNil(section.nibForFooter)
    }
    
    func testSizeForFooter() {
        XCTAssertEqual(section.sizeForFooter(container), footerSize)
    }
    
    func testMinimumLineSpacing() {
        XCTAssertEqual(section.minimumLineSpacing(container), minimumLineSpacing)
    }
    
    func testMinimumInteritemSpacing() {
        XCTAssertEqual(section.minimumInteritemSpacing(container), minimumInteritemSpacing)
    }
    
    func testDidEndDisplayingHeader() {
        section.didEndDisplayingHeader()
    }
    
    func testDidEndDisplayingFooter() {
        section.didEndDisplayingFooter()
    }
}
