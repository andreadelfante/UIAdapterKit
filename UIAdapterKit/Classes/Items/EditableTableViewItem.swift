//
//  EditableTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea on 25/06/2019.
//

#if canImport(UIKit)

import UIKit

public protocol EditableTableViewItem: TableViewItem {
	var editingStyle: UITableViewCell.EditingStyle { get }
	func editingAction()
}

#endif
