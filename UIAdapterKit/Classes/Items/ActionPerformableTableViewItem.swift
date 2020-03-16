//
//  ActionPerformableTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 12/06/2019.
//

#if canImport(UIKit)

import Foundation

public protocol ActionPerformableItem: Item {
    func canPerform(action: Selector, withSender sender: Any?) -> Bool
    func perform(action: Selector, withSender sender: Any?)
}

public protocol ActionPerformableTableViewItem: ActionPerformableItem, TableViewItem {}

public protocol ActionPerformableCollectionViewItem: ActionPerformableItem, CollectionViewItem {}

#endif
