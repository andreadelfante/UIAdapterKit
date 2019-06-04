//
//  User.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery

struct User: Fakeable {
    let firstName: String
    let lastName: String
    let text: String
    
    init(faker: Faker) {
        firstName = faker.name.firstName()
        lastName = faker.name.lastName()
        text = faker.lorem.paragraph()
    }
}
