//
//  SwipeableTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 10/06/2019.
//

#if canImport(UIKit)

import UIKit

public protocol SwipeableTableViewItem: TableViewItem {
    var actions: [UITableViewRowAction] { get }
}

#endif
