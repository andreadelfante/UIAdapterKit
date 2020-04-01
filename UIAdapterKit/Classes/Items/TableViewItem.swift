//
//  TableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

public protocol TableViewItem: Item {
    func configure(cell: UITableViewCell)

    func willDisplay(cell: UITableViewCell)

    func height(_ container: Container) -> CGFloat?
    var indentationLevel: Int { get }
}

public extension TableViewItem {
    func willDisplay(cell: UITableViewCell) {}

    func height(_ container: Container) -> CGFloat? { return nil }

    var indentationLevel: Int { return 1 }
}

public extension TableViewItem {
    func registerCell(for tableView: UITableView) {
        switch registrationType {
        case .nib(let nib):
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        case .clazz(let clazz):
            tableView.register(clazz, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }

        registerCell(for: tableView)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    }
}

#endif
