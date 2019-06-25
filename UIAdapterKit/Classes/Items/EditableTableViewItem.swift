//
//  EditableTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea on 25/06/2019.
//

import UIKit

public protocol EditableTableViewItem: TableViewItem {
	var editingStyle: UITableViewCell.EditingStyle { get }
	var editingAction: () -> Void { get }
}
