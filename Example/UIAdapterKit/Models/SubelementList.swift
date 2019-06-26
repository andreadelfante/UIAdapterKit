//
//  SubelementList.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 25/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery
import RealmSwift
import PredicateFlow

class SubelementList: Object, Fakeable, PredicateSchema {
    @objc dynamic private(set) var word: String!
    
    required convenience init(faker: Faker) {
        self.init()
        
        word = faker.lorem.word()
    }
}
