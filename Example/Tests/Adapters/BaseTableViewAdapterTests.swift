//
//  BaseTableViewAdapterTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 11/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

class BaseTableViewAdapterTests: XCTestCase {
    private var adapter: MockTableViewAdapter!
    private var tableView: UITableView!
    private var indexPath: IndexPath!
    private var faker: Faker!
    private var selector: Selector!
    
    override func setUp() {
        super.setUp()
        
        adapter = MockTableViewAdapter()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), style: .grouped)
        indexPath = IndexPath(row: 0, section: 0)
        faker = Faker()
        selector = Selector("")
    }
    
    override func tearDown() {
        adapter = nil
        tableView = nil
        indexPath = nil
        faker = nil
        selector = nil
        
        super.tearDown()
    }
    
    func testNumberOfSectionsInTableView() {
        XCTAssertEqual(adapter.numberOfSections(in: tableView), adapter.sectionCount)
    }
    
    func testTableViewNumberOfRowsInSection() {
        adapter.sectionBuilder = { _ in MockSection() }
        
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: -1), 0)
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), 1)
    }
    
    func testTableViewCellForRowAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in MockItem() }
            return section
        }
        
        XCTAssertEqual(adapter.tableView(tableView, cellForRowAt: indexPath).reuseIdentifier, MockItem().dequeueCell(from: tableView, at: indexPath).reuseIdentifier)
    }
    
    func testTableViewShouldHighlightRowAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.didSelectItem = {}
                return item
            }
            return section
        }
        
        XCTAssertTrue(adapter.tableView(tableView, shouldHighlightRowAt: indexPath))
    }
    
    func testTableViewDidSelectRowAt() {
        let expected = expectation(description: "testDidSelectRowAt")
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
        
        adapter.tableView(tableView, didSelectRowAt: indexPath)
        wait(for: [expected], timeout: 5)
    }
    
    func testTableViewDidDeselectRowAt() {
        let expected = expectation(description: "testDidDeselectRowAt")
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
        
        adapter.tableView(tableView, didDeselectRowAt: indexPath)
        wait(for: [expected], timeout: 5)
    }
    
    func testTableViewHeightForRowAt() {
        let expected = CGFloat(faker.number.randomInt())
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.heightForRow = expected
                return item
            }
            return section
        }
        
        XCTAssertEqual(expected, adapter.tableView(tableView, heightForRowAt: indexPath))
    }
    
    func testTableViewTitleForHeaderInSection() {
        let expected = faker.lorem.paragraph()
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.headerString = expected
            return section
        }
        
        XCTAssertEqual(expected, adapter.tableView(tableView, titleForHeaderInSection: 0))
    }
    
    func testTableViewViewForHeaderInSection() {
        adapter.sections = 0
        XCTAssertNil(adapter.tableView(tableView, viewForHeaderInSection: 0))
        
        adapter.sections = 1
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.items = 0
            return section
        }
        XCTAssertNil(adapter.tableView(tableView, viewForHeaderInSection: 0))
        
        let view = UITableViewHeaderFooterView()
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.headerView = view
            return section
        }
        XCTAssertEqual(view, adapter.tableView(tableView, viewForHeaderInSection: 0))
    }
    
    func testTableViewHeightForHeaderInSection() {
        let expected = CGFloat(faker.number.randomInt())
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.heightForHeader = expected
            return section
        }
        
        adapter.sections = 0
        var result = adapter.tableView(tableView, heightForHeaderInSection: 0)
        XCTAssert(0 <= result && result <= 0.1)
        
        adapter.sections = 1
        result = adapter.tableView(tableView, heightForHeaderInSection: 0)
        XCTAssertEqual(result, expected)
    }
    
    func testTableViewTitleForFooterInSection() {
        let expected = faker.lorem.paragraph()
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.footerString = expected
            return section
        }
        
        XCTAssertEqual(expected, adapter.tableView(tableView, titleForFooterInSection: 0))
    }
    
    func testTableViewViewForFooterInSection() {
        adapter.sections = 0
        XCTAssertNil(adapter.tableView(tableView, viewForFooterInSection: 0))
        
        adapter.sections = 1
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.items = 0
            return section
        }
        XCTAssertNil(adapter.tableView(tableView, viewForFooterInSection: 0))
        
        let view = UITableViewHeaderFooterView()
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.footerView = view
            return section
        }
        XCTAssertEqual(view, adapter.tableView(tableView, viewForFooterInSection: 0))
    }
    
    func testTableViewHeightForFooterInSection() {
        let expected = CGFloat(faker.number.randomInt())
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.heightForFooter = expected
            return section
        }
        
        adapter.sections = 0
        var result = adapter.tableView(tableView, heightForFooterInSection: 0)
        XCTAssert(0 <= result && result <= 0.1)
        
        adapter.sections = 1
        result = adapter.tableView(tableView, heightForFooterInSection: 0)
        XCTAssertEqual(result, expected)
    }
    
    func testTableViewCanEditRowAt() {
        adapter.sections = 0
        XCTAssertFalse(adapter.tableView(tableView, canEditRowAt: indexPath))
        
        adapter.sections = 1
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.actions = []
                return item
            }
            return section
        }
        XCTAssertFalse(adapter.tableView(tableView, canEditRowAt: indexPath))
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.actions = [
                    UITableViewRowAction(style: .default, title: nil, handler: { (_, _) in })
                ]
                return item
            }
            return section
        }
        XCTAssertTrue(adapter.tableView(tableView, canEditRowAt: indexPath))
    }
    
    func testTableViewEditActionsForRowAt() {
        adapter.sections = 0
        XCTAssertNil(adapter.tableView(tableView, editActionsForRowAt: indexPath))
        
        adapter.sections = 1
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.actions = [
                    UITableViewRowAction(style: .default, title: nil, handler: { (_, _) in })
                ]
                return item
            }
            return section
        }
        
        let result = adapter.tableView(tableView, editActionsForRowAt: indexPath)
        XCTAssertNotNil(result)
        XCTAssertFalse(result!.isEmpty)
    }
    
    func testTableViewShouldShowMenuForRowAt() {
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                return MockItem()
            }
            return section
        }
        
        XCTAssertEqual(adapter.tableView(tableView, shouldShowMenuForRowAt: indexPath), true)
    }
    
    func testTableViewCanPerformActionForRowAtWithSender() {
        XCTAssertFalse(adapter.tableView(tableView, canPerformAction: selector, forRowAt: indexPath, withSender: nil))
        
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.canPerform = { _, _ in return true }
                return item
            }
            return section
        }
        
        XCTAssertTrue(adapter.tableView(tableView, canPerformAction: selector, forRowAt: indexPath, withSender: nil))
    }
    
    func testTableViewPerformActionForRowAtWithSender() {
        let expected = expectation(description: "testTableViewPerformActionForRowAtWithSender")
        
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
        
        adapter.tableView(tableView, performAction: selector, forRowAt: indexPath, withSender: nil)
        wait(for: [expected], timeout: 5)
        XCTAssertTrue(result)
    }
    
    func testTableViewIndentationLevelForRowAt() {
        let number = faker.number.randomInt()
        adapter.sectionBuilder = { _ in
            let section = MockSection()
            section.itemBuilder = { _ in
                let item = MockItem()
                item.indentationLevel = number
                return item
            }
            return section
        }
        
        XCTAssertEqual(adapter.tableView(tableView, indentationLevelForRowAt: indexPath), number)
    }
	
	func testTableViewEditingStyleForRowAt() {
		XCTAssertEqual(adapter.tableView(tableView, editingStyleForRowAt: indexPath), .none)
		
		let style: UITableViewCell.EditingStyle = [.delete, .insert].randomElement()!
		adapter.sectionBuilder = { _ in
			let section = MockSection()
			section.itemBuilder = { _ in
				let item = MockItem()
				item.editingStyle = style
				return item
			}
			return section
		}
		
		XCTAssertEqual(adapter.tableView(tableView, editingStyleForRowAt: indexPath), style)
	}
	
	func testTableViewCommitEditingStyleForRowAt() {
		[
			(UITableViewCell.EditingStyle.delete, true),
			(UITableViewCell.EditingStyle.insert, false)
		].forEach { (expected) in
			var result = false
			adapter.sectionBuilder = { _ in
				let section = MockSection()
				section.itemBuilder = { _ in
					let item = MockItem()
					item.editingStyle = .delete
					item.editingStyleAction = {
						result = true
					}
					return item
				}
				return section
			}
			
			adapter.tableView(tableView, commit: expected.0, forRowAt: indexPath)
			XCTAssertEqual(expected.1, result)
		}
	}
}

// MARK: Fileprivate

fileprivate class MockItem: TableViewItem, SwipeableTableViewItem, ActionPerformableTableViewItem, EditableTableViewItem {
    var didSelectItem: SelectionCompletion?
    var didDeselectItem: SelectionCompletion?
    var heightForRow: CGFloat?
    var actions: [UITableViewRowAction] = []
    var canPerform: ((Selector, Any?) -> Bool)?
    var perform: ((Selector, Any?) -> Void)?
    var indentationLevel: Int = 1
	var editingStyle: UITableViewCell.EditingStyle = .none
	var editingStyleAction: () -> Void = {}
    
    var registrationType: RegistrationType {
        return .clazz(UITableViewCell.self)
    }
    
    func configure(cell: UITableViewCell) {
        
    }
    
    func height(_ container: Container) -> CGFloat? {
        return heightForRow
    }
    
    func canPerform(action: Selector, withSender sender: Any?) -> Bool {
        return canPerform!(action, sender)
    }
    
    func perform(action: Selector, withSender sender: Any?) {
        perform!(action, sender)
    }
	
	func editingAction() {
		self.editingStyleAction()
	}
}

fileprivate class MockSection: TableViewSection {
    var items: Int = 1
    var itemBuilder: ((Int) -> Item?)?
    var heightForHeader: CGFloat?
    var heightForFooter: CGFloat?
    var headerString: String?
    var footerString: String?
    var headerView: UITableViewHeaderFooterView?
    var footerView: UITableViewHeaderFooterView?
    
    var count: Int {
        return items
    }
    
    func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder?(index)
    }
    
    func heightForHeader(_ container: Container) -> CGFloat? {
        return heightForHeader
    }
    
    func heightForFooter(_ container: Container) -> CGFloat? {
        return heightForFooter
    }
    
    var headerTitle: String? {
        return headerString
    }
    
    var footerTitle: String? {
        return footerString
    }
    
    func dequeueHeader(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return headerView
    }
    
    func dequeueFooter(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return footerView
    }
    
    func registerHeaderFooter(for tableView: UITableView) {
        
    }
}

fileprivate class MockTableViewAdapter: BaseTableViewAdapter {
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
