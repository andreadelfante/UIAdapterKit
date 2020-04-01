//
//  BaseTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 30/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class BaseTableViewSection: Section, Copyable {
    public let headerTitle: String?
    public let footerTitle: String?
    public let headerHeight: CGFloat?
    public let footerHeight: CGFloat?

    public init(
        headerTitle: String? = nil,
        footerTitle: String? = nil,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil
    ) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }

    public required init(instance: BaseTableViewSection) {
        headerTitle = instance.headerTitle
        footerTitle = instance.footerTitle
        headerHeight = instance.headerHeight
        footerHeight = instance.footerHeight
    }

    open var count: Int {
        fatalError("Must override")
    }

    open func item(for index: Int) -> Item? {
        fatalError("Must override")
    }

    open var titleForHeader: String? {
        return headerTitle
    }

    open var titleForFooter: String? {
        return footerTitle
    }

    open var nibForHeader: UINib? {
        return nil
    }

    open var nibForFooter: UINib? {
        return nil
    }

    open var reuseIdentifierForHeader: String {
        return "\(identifier(self)).Header"
    }

    open var reuseIdentifierForFooter: String {
        return "\(identifier(self)).Footer"
    }

    open func configure(header: UITableViewHeaderFooterView) {
    }

    open func configure(footer: UITableViewHeaderFooterView) {
    }

    open func heightForHeader(_ container: Container) -> CGFloat? {
        return headerHeight
    }

    open func heightForFooter(_ container: Container) -> CGFloat? {
        return footerHeight
    }

    open func didEndDisplayingHeader() {
    }

    open func didEndDisplayingFooter() {
    }

    open func dequeueHeader(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader) {
            return header
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader)
    }

    open func dequeueFooter(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter) {
            return footer
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter)
    }

    open func registerHeaderFooter(for tableView: UITableView) {
        if let nib = nibForHeader {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForHeader)
        }

        if let nib = nibForFooter {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForFooter)
        }
    }
}

#endif
