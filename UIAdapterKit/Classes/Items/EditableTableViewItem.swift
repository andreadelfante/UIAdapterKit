//
//  EditableTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 10/06/2019.
//

public protocol EditableTableViewItem: TableViewItem {
    var actions: [UITableViewRowAction] { get }
}
