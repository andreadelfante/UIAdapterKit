//
//  DefaultTableViewItemTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 06/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

class DefaultTableViewItemTests: XCTestCase {
    
    private var tableView: UITableView!
    private var faker: Faker!
    
    override func setUp() {
        super.setUp()
        
        tableView = UITableView()
        faker = Faker()
    }
    
    func testConfigure() {
        let text = faker.lorem.sentence()
        let detailText = faker.lorem.paragraph()
        
        let item = DefaultTableViewItem(
            style: .subtitle,
            image: nil,
            text: text,
            detailText: detailText,
            accessoryType: .disclosureIndicator
        )
        
        let cell = item.dequeueCell(from: tableView, at: IndexPath())
        item.configure(cell: cell)
        
        XCTAssertNil(cell.imageView?.image)
        XCTAssertEqual(cell.textLabel?.text, text)
        XCTAssertEqual(cell.detailTextLabel?.text, detailText)
        XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
    }
    
    func testRegistrationType() {
        let item = DefaultTableViewItem(text: nil)
        
        XCTAssertEqual(item.registrationType, .clazz(UITableViewCell.self))
    }
    
    func testIndentationLevel() {
        let item = DefaultTableViewItem(text: nil)
        
        XCTAssertEqual(item.indentationLevel, 1)
    }
    
    func testDidEndDisplayingItem() {
        let item = DefaultTableViewItem(text: nil)
        
        item.didEndDisplayingItem()
    }
}
