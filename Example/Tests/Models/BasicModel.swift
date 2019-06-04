//
//  BasicModel.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery

struct BasicModel: Fakeable {
    let text: String
    let detail: String
    
    init(faker: Faker) {
        text = faker.lorem.sentence()
        detail = faker.lorem.paragraphs()
    }
}
