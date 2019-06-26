//
//  EditableTableViewItemTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 10/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

fileprivate class MockItem: DefaultTableViewItem, EditableTableViewItem {
    let editingStyle: UITableViewCell.EditingStyle
    let action: () -> Void
    
    init(editingStyle: UITableViewCell.EditingStyle, action: @escaping () -> Void) {
        self.editingStyle = editingStyle
        self.action = action
        
        super.init(text: nil)
    }
    
    func editingAction() {
        action()
    }
}

class EditableTableViewItemTests: XCTestCase {
    private var item: MockItem!
    private var actionResult: Bool!
    
    override func setUp() {
        super.setUp()
        
        actionResult = false
        item = MockItem(editingStyle: .delete, action: {
            self.actionResult = true
        })
    }
    
    func testEditingStyle() {
        XCTAssertEqual(item.editingStyle, .delete)
    }
    
    func testEditingAction() {
        item.editingAction()
        
        XCTAssertTrue(actionResult)
    }
}
