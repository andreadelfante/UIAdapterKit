//
//  RealmFilterableSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 19/06/2019.
//

#if canImport(UIKit)

import Foundation

public protocol RealmPerformableFilter {
    func performFilter(with payload: Any)
}

public protocol RealmFilterableSection: RealmPerformableFilter {
    func filter(with payload: Any) -> NSPredicate?
}

#endif
