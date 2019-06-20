//
//  User.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery
import RealmSwift
import PredicateFlow

class User: Object, Fakeable, PredicateSchema {
    @objc dynamic private(set) var firstName: String!
    @objc dynamic private(set) var lastName: String!
    @objc dynamic private(set) var text: String!
    
    required convenience init(faker: Faker) {
        self.init()
        
        firstName = faker.name.firstName()
        lastName = faker.name.lastName()
        text = faker.lorem.paragraph()
    }
}
