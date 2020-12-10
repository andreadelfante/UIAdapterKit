//
//  BasicModel.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Fakery
import RealmSwift

class BasicModel: Object, Fakeable {
    @objc private(set) var text: String!
    @objc private(set) var detail: String!
    
    required convenience init(faker: Faker) {
        self.init()
        
        text = faker.lorem.sentence()
        detail = faker.lorem.paragraphs()
    }
    
    override class func primaryKey() -> String? {
        return "text"
    }
}
