//
//  BasicSection.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIAdapterKit

struct BasicSection: Section {
    
    let items: [BasicItem]
    
    var count: Int {
        return items.count
    }
    
    func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return items[index]
    }
}
