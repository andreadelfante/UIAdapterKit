//
//  RealmItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 07/06/2019.
//

#if canImport(UIKit)

#if SWIFT_PACKAGE
import UIAdapterKit
#endif

public protocol RealmItem: Item {}

public protocol RealmTableViewItem: TableViewItem, RealmItem {}

public protocol RealmCollectionViewItem: CollectionViewItem, RealmItem {}

#endif
