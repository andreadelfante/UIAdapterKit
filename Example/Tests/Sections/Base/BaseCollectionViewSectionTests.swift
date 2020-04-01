//
//  BaseCollectionViewSectionTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

class BaseCollectionViewSectionTests: XCTestCase {
    private var headerSize: CGSize!
    private var footerSize: CGSize!
    private var minimumLineSpacing: CGFloat!
    private var minimumInteritemSpacing: CGFloat!
    private var collectionView: UICollectionView!
    private var section: BaseCollectionViewSection!
    
    override func setUp() {
        super.setUp()
        
        headerSize = CGSize(width: 20, height: 20)
        footerSize = CGSize(width: 10, height: 10)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 100
        section = BaseCollectionViewSection(
            headerSize: headerSize,
            footerSize: footerSize,
            minimumLineSpacing: minimumLineSpacing,
            minimumInteritemSpacing: minimumInteritemSpacing
        )
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    func testHeaderSize() {
        XCTAssertEqual(section.headerSize, headerSize)
        XCTAssertEqual(section.sizeForHeader(collectionView), headerSize)
    }
    
    func testFooterSize() {
        XCTAssertEqual(section.headerSize, headerSize)
        XCTAssertEqual(section.sizeForHeader(collectionView), headerSize)
    }
    
    func testMinimumInteritemSpacing() {
        XCTAssertEqual(section.minimumInteritemSpacing, minimumInteritemSpacing)
        XCTAssertEqual(section.minimumInteritemSpacing(collectionView), minimumInteritemSpacing)
    }
    
    func testMinimumLineSpacing() {
        XCTAssertEqual(section.minimumLineSpacing, minimumLineSpacing)
        XCTAssertEqual(section.minimumLineSpacing(collectionView), minimumLineSpacing)
    }
    
    func testReuseIdentifierForHeader() {
        XCTAssertEqual(section.reuseIdentifierForHeader, "BaseCollectionViewSection.Header")
    }
    
    func testReuseIdentifierForFooter() {
        XCTAssertEqual(section.reuseIdentifierForFooter, "BaseCollectionViewSection.Footer")
    }
    
    func testCopy() {
        let copy = section.copy()
        
        XCTAssertEqual(copy.headerSize, section.headerSize)
        XCTAssertEqual(copy.footerSize, section.footerSize)
        XCTAssertEqual(copy.minimumLineSpacing, section.minimumLineSpacing)
        XCTAssertEqual(copy.minimumInteritemSpacing, section.minimumInteritemSpacing)
    }
}
