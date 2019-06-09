//
//  RealmItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 07/06/2019.
//

public protocol RealmItem: Item {}

public protocol RealmTableViewItem: TableViewItem, RealmItem {}

public protocol RealmCollectionViewItem: CollectionViewItem, RealmItem {}
