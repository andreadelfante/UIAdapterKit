//
//  FilterableSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation

public protocol PerformableFilter {
    func performFilter(with payload: Any)
}

public protocol FilterableSection: PerformableFilter {
    associatedtype Item

    func filter(item: Item, with payload: Any) -> Bool
}

#endif
