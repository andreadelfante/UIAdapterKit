//
//  Copyable.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 20/06/2019.
//

#if canImport(UIKit)

public protocol Copyable {
    init(instance: Self)
}

public extension Copyable {
    func copy() -> Self {
        return type(of: self).init(instance: self)
    }
}

#endif
