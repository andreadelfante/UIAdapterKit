//
//  ContainerTests.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 05/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
@testable import UIAdapterKit

struct MockContainer: Container {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    
    var containerSize: CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

class ContainerTests: XCTestCase {
    let faker = Faker()
    
    func testContainerSize() {
        let x = faker.number.randomInt()
        let y = faker.number.randomInt()
        let width = faker.number.randomInt()
        let height = faker.number.randomInt()
        
        let mock = MockContainer(x: x, y: y, width: width, height: height)
        
        XCTAssertEqual(mock.containerSize.width, CGFloat(width))
        XCTAssertEqual(mock.containerSize.height, CGFloat(height))
    }
}
