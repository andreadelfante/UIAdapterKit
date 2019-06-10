//
//  EditableTableViewItemTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 10/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

let baseActions = [
    UITableViewRowAction(style: .default, title: "Default", handler: { (_, _) in })
]

class MockItem: DefaultTableViewItem, EditableTableViewItem {
    var actions: [UITableViewRowAction] {
        return baseActions
    }
}

class EditableTableViewItemTests: XCTestCase {
    private var item: MockItem!
    
    override func setUp() {
        super.setUp()
        
        item = MockItem(text: nil)
    }
    
    func testActions() {
        XCTAssertEqual(item.actions, baseActions)
    }
}
