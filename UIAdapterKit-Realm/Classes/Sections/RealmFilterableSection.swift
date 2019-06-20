//
//  RealmFilterableSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 19/06/2019.
//

public protocol RealmFilterableSection {
    func filter(with payload: Any) -> NSPredicate?
}

protocol RealmFilterableBridging {
    func performFilter(with payload: Any)
}
