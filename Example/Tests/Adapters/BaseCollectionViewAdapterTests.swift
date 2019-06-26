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
    private var selector: Selector!

    override func setUp() {
        super.setUp()
        
        adapter = MockCollectionViewAdapter()
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), collectionViewLayout: layout)
        indexPath = IndexPath(row: 0, section: 0)
        faker = Faker()
        selector = Selector("")
    }

    override func tearDown() {
        adapter = nil
        collectionView = nil
        layout = nil
        indexPath = nil
        faker = nil
        selector = nil
        
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
        
        XCTAssertEqual(expected, adapter.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath))
        XCTAssertEqual(expected, adapter.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath))
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
    
    func testCollectionViewShouldShowMenuForItemAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                return MockItem()
            }
            return section
        }
        
        XCTAssertEqual(adapter.collectionView(collectionView, shouldShowMenuForItemAt: indexPath), true)
    }
    
    func testCollectionViewCanPerformActionForItemAtWithSender() {
        XCTAssertFalse(adapter.collectionView(collectionView, canPerformAction: selector, forItemAt: indexPath, withSender: nil))
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.canPerform = { _, _ in return true }
                return item
            }
            return section
        }
        
        XCTAssertTrue(adapter.collectionView(collectionView, canPerformAction: selector, forItemAt: indexPath, withSender: nil))
    }
    
    func testCollectionViewPerformActionForItemAtWithSender() {
        let expected = expectation(description: "testCollectionViewPerformActionForItemAtWithSender")
        
        var result = false
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.perform = { _, _ in
                    result = true
                    expected.fulfill()
                }
                return item
            }
            return section
        }
        
        adapter.collectionView(collectionView, performAction: selector, forItemAt: indexPath, withSender: nil)
        wait(for: [expected], timeout: 5)
        XCTAssertTrue(result)
    }
    
    func testDidEndDisplayingHeader() {
        var result = false
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.endDisplayingHeader = {
                result = true
            }
            return section
        }
        
        adapter.collectionView(collectionView, didEndDisplayingSupplementaryView: UICollectionReusableView(), forElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        XCTAssertTrue(result)
    }
    
    func testDidEndDisplayingItem() {
        var result = false
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.endDisplayingItem = {
                    result = true
                }
                return item
            }
            return section
        }
        
        adapter.collectionView(collectionView, didEndDisplaying: UICollectionViewCell(), forItemAt: indexPath)
        XCTAssertTrue(result)
    }
    
    func testDidEndDisplayingFooter() {
        var result = false
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.endDisplayingFooter = {
                result = true
            }
            return section
        }
        
        adapter.collectionView(collectionView, didEndDisplayingSupplementaryView: UICollectionReusableView(), forElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)
        XCTAssertTrue(result)
    }
}

fileprivate class MockItem: CollectionViewItem, ActionPerformableCollectionViewItem {
    var didSelectItem: SelectionCompletion?
    var didDeselectItem: SelectionCompletion?
    var size: CGSize?
    var canPerform: ((Selector, Any?) -> Bool)?
    var perform: ((Selector, Any?) -> Void)?
    var endDisplayingItem: () -> Void = {}
    
    func configure(cell: UICollectionViewCell) {
        
    }
    
    var registrationType: RegistrationType {
        return .clazz(UICollectionViewCell.self)
    }
    
    func size(_ container: Container) -> CGSize? {
        return size
    }
    
    func canPerform(action: Selector, withSender sender: Any?) -> Bool {
        return canPerform!(action, sender)
    }
    
    func perform(action: Selector, withSender sender: Any?) {
        perform!(action, sender)
    }
    
    func didEndDisplayingItem() {
        self.endDisplayingItem()
    }
}

fileprivate class MockSection: CollectionViewSection {
    var items: Int = 1
    var itemBuilder: ((Int) -> Item?)?
    var sizeForHeader: CGSize?
    var sizeForFooter: CGSize?
    var headerFooterView: UICollectionReusableView?
    var endDisplayingHeader: () -> Void = {}
    var endDisplayingFooter: () -> Void = {}
    
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
    
    func didEndDisplayingHeader() {
        endDisplayingHeader()
    }
    
    func didEndDisplayingFooter() {
        endDisplayingFooter()
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
