//
//  DefaultTableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 06/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

#if SWIFT_PACKAGE
import UIAdapterKit
#endif

open class DefaultTableViewItem: TableViewItem {

    public let style: UITableViewCell.CellStyle
    public let image: UIImage?
    public let text: String?
    public let detailText: String?
    public let accessoryType: UITableViewCell.AccessoryType
    public let didSelectItem: SelectionCompletion?
    public let didDeselectItem: SelectionCompletion?

    public init(style: UITableViewCell.CellStyle = .default,
                image: UIImage? = nil,
                text: String?,
                detailText: String? = nil,
                accessoryType: UITableViewCell.AccessoryType = .none,
                didSelectItem: SelectionCompletion? = nil,
                didDeselectItem: SelectionCompletion? = nil) {
        self.style = style
        self.image = image
        self.text = text
        self.detailText = detailText
        self.accessoryType = accessoryType
        self.didSelectItem = didSelectItem
        self.didDeselectItem = didDeselectItem
    }

    open func configure(cell: UITableViewCell) {
        cell.imageView?.image = image
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = detailText
        cell.accessoryType = accessoryType
    }

    open func didEndDisplayingItem() {

    }

    public var registrationType: RegistrationType {
        return .clazz(UITableViewCell.self)
    }

    public func registerCell(for tableView: UITableView) {

    }

    public func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: style, reuseIdentifier: reuseIdentifier)
    }
}

#endif
