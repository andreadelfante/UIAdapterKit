//
//  ItemTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UIAdapterKit

class ItemTests: XCTestCase {
    
    private var item: BasicItem!
    
    override func setUp() {
        super.setUp()
        
        item = BasicItem()
    }
    
    func testReuseIdentifier() {
        XCTAssertEqual(item.reuseIdentifier, "BasicItem")
    }
    
    func testRegistrationType() {
        XCTAssertEqual(item.registrationType, .nib(UINib(nibName: item.reuseIdentifier, bundle: nil)))
    }
}
