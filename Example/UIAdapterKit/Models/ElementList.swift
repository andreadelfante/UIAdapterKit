//
//  ElementList.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 25/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery
import RealmSwift
import PredicateFlow

class ElementList: Object, Fakeable, PredicateSchema {
    @objc dynamic private(set) var title: String!
    private let elements = List<SubelementList>()
    
    required convenience init(faker: Faker) {
        self.init()
        
        title = faker.lorem.sentence()
        elements.append(objectsIn: SubelementList.fake(faker.number.randomInt(min: 1, max: 15)))
    }
    
    var sortedElements: Results<SubelementList> {
        return elements.sorted(SubelementListSchema.word.ascending())
    }
}
