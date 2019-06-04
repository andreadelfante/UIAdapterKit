//
//  Fakeable.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Fakery

protocol Fakeable {
    init(faker: Faker)
}

extension Fakeable {
    static func fake() -> Self {
        return fake(1).first!
    }
    
    static func fake(_ number: Int) -> [Self] {
        let faker = Faker()
        return (0..<number).map { _ in
            Self.init(faker: faker)
        }
    }
}
