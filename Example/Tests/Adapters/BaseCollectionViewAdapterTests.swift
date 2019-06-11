//
//  BaseCollectionViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 12/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

class BaseCollectionViewAdapterTests: XCTestCase {
    private var adapter: MockCollectionViewAdapter!
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var indexPath: IndexPath!
    private var faker: Faker!

    override func setUp() {
        super.setUp()
        
        adapter = MockCollectionViewAdapter()
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), collectionViewLayout: layout)
        indexPath = IndexPath(row: 0, section: 0)
        faker = Faker()
    }

    override func tearDown() {
        adapter = nil
        collectionView = nil
        layout = nil
        indexPath = nil
        faker = nil
        
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(adapter.sectionCount, adapter.numberOfSections(in: collectionView))
    }
    
    func testCollectionViewNumberOfItemsInSection() {
        adapter.sectionBuilder = { _ in MockSection() }
        
        XCTAssertEqual(0, adapter.collectionView(collectionView, numberOfItemsInSection: -1))
        XCTAssertEqual(1, adapter.collectionView(collectionView, numberOfItemsInSection: 0))
    }
    
    func testCollectionViewCellForItemAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in MockItem() }
            return section
        }
        
        XCTAssertEqual(adapter.collectionView(collectionView, cellForItemAt: indexPath).reuseIdentifier, MockItem().dequeueCell(from: collectionView, at: indexPath).reuseIdentifier)
    }
    
    func testCollectionViewShouldHighlightItemAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.didSelectItem = {}
                return item
            }
            return section
        }
        
        XCTAssertTrue(adapter.collectionView(collectionView, shouldHighlightItemAt: indexPath))
    }
    
    func testCollectionViewDidSelectItemAt() {
        let expected = expectation(description: "testDidSelectItemAt")
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.didSelectItem = {
                    expected.fulfill()
                }
                return item
            }
            return section
        }
        
        adapter.collectionView(collectionView, didSelectItemAt: indexPath)
        wait(for: [expected], timeout: 5)
    }
    
    func testCollectionViewDidDeselectItemAt() {
        let expected = expectation(description: "testDidDeselectItemAt")
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.didDeselectItem = {
                    expected.fulfill()
                }
                return item
            }
            return section
        }
        
        adapter.collectionView(collectionView, didDeselectItemAt: indexPath)
        wait(for: [expected], timeout: 5)
    }
    
    func testCollectionViewLayoutSizeForItemAt() {
        let expected = CGSize(width: faker.number.randomInt(),
                              height: faker.number.randomInt())
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.size = expected
                return item
            }
            return section
        }
        
        adapter.sections = 0
        XCTAssertEqual(adapter.collectionView(collectionView, layout: layout, sizeForItemAt: indexPath), layout.itemSize)
        
        adapter.sections = 1
        XCTAssertEqual(adapter.collectionView(collectionView, layout: layout, sizeForItemAt: indexPath), expected)
    }
    
    func testCollectionViewViewForSupplementaryElementOfKindAt() {
        let expected = UICollectionReusableView()
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.headerFooterView = expected
            return section
        }
        
        XCTAssertEqual(expected, adapter.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: indexPath))
        XCTAssertEqual(expected, adapter.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionFooter, at: indexPath))
    }
    
    func testCollectionViewLayoutReferenceSizeForHeaderInSection() {
        let expected = CGSize(width: faker.number.randomInt(),
                              height: faker.number.randomInt())
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.sizeForHeader = expected
            return section
        }
        
        adapter.sections = 0
        XCTAssertEqual(CGSize.zero, adapter.collectionView(collectionView, layout: layout, referenceSizeForHeaderInSection: 0))
        
        adapter.sections = 1
        XCTAssertEqual(expected, adapter.collectionView(collectionView, layout: layout, referenceSizeForHeaderInSection: 0))
    }
    
    func collectionViewLayoutReferenceSizeForFooterInSection() {
        let expected = CGSize(width: faker.number.randomInt(),
                              height: faker.number.randomInt())
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.sizeForFooter = expected
            return section
        }
        
        adapter.sections = 0
        XCTAssertEqual(CGSize.zero, adapter.collectionView(collectionView, layout: layout, referenceSizeForFooterInSection: 0))
        
        adapter.sections = 1
        XCTAssertEqual(expected, adapter.collectionView(collectionView, layout: layout, referenceSizeForFooterInSection: 0))
    }
}

fileprivate class MockItem: CollectionViewItem {
    var didSelectItem: SelectionCompletion?
    var didDeselectItem: SelectionCompletion?
    var size: CGSize?
    
    func configure(cell: UICollectionViewCell) {
        
    }
    
    var registrationType: RegistrationType {
        return .clazz(UICollectionViewCell.self)
    }
    
    func size(_ container: Container) -> CGSize? {
        return size
    }
}

fileprivate class MockSection: CollectionViewSection {
    var items: Int = 1
    var itemBuilder: ((Int) -> Item?)?
    var sizeForHeader: CGSize?
    var sizeForFooter: CGSize?
    var headerFooterView: UICollectionReusableView?
    
    var count: Int {
        return items
    }
    
    func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder?(index)
    }
    
    func sizeForHeader(_ container: Container) -> CGSize? {
        return sizeForHeader
    }
    
    func sizeForFooter(_ container: Container) -> CGSize? {
        return sizeForFooter
    }
    
    func dequeueSupplementaryView(for collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return headerFooterView
    }
    
    func registerSupplementaryView(for collectionView: UICollectionView) {
        
    }
}

fileprivate class MockCollectionViewAdapter: BaseCollectionViewAdapter {
    var sections: Int = 1
    var sectionBuilder: ((Int) -> Section?)?
    
    override var sectionCount: Int {
        return sections
    }
    
    override func section(for index: Int) -> Section? {
        guard 0 <= index && index < sectionCount else { return nil }
        return sectionBuilder?(index)
    }
}
