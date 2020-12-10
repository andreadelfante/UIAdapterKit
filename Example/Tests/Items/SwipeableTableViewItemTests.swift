//
//  SwipeableTableViewItemTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 26/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import XCTest
@testable import UIAdapterKit

let baseActions = [
    UITableViewRowAction(style: .default, title: "Default", handler: { (_, _) in })
]

fileprivate class MockItem: DefaultTableViewItem, SwipeableTableViewItem {
    var actions: [UITableViewRowAction] {
        return baseActions
    }
}

class SwipeableTableViewItemTests: XCTestCase {
    private var item: MockItem!
    
    override func setUp() {
        super.setUp()
        
        item = MockItem(text: nil)
    }
    
    func testActions() {
        XCTAssertEqual(item.actions, baseActions)
    }
}

#endif
