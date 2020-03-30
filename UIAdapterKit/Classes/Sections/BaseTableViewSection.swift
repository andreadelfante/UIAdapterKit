//
//  BaseTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 30/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class BaseTableViewSection: NSObject, Section, Copyable {
    private let _headerTitle: String?
    private let _footerTitle: String?
    private let _headerHeight: CGFloat?
    private let _footerHeight: CGFloat?
    
    public init(
        headerTitle: String? = nil,
        footerTitle: String? = nil,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil
    ) {
        self._headerTitle = headerTitle
        self._footerTitle = footerTitle
        self._headerHeight = headerHeight
        self._footerHeight = footerHeight
    }
    
    public required init(instance: BaseTableViewSection) {
        _headerTitle = instance._headerTitle
        _footerTitle = instance._footerTitle
        _headerHeight = instance._headerHeight
        _footerHeight = instance._footerHeight
    }
    
    public override func copy() -> Any {
        return type(of: self).init(instance: self)
    }
    
    public var count: Int {
        fatalError("Must override")
    }
    
    public func item(for index: Int) -> Item? {
        fatalError("Must override")
    }
    
    open var titleForHeader: String? {
        return _headerTitle
    }
    
    open var titleForFooter: String? {
        return _footerTitle
    }
    
    open var nibForHeader: UINib? {
        return nil
    }

    open var nibForFooter: UINib? {
        return nil
    }

    open func heightForHeader(_ container: Container) -> CGFloat? {
        return _headerHeight
    }
    
    open func heightForFooter(_ container: Container) -> CGFloat? {
        return _footerHeight
    }
    
    open func didEndDisplayingHeader() {
    }

    open func didEndDisplayingFooter() {
    }

    func dequeueHeader(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader) {
            return header
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader)
    }

    func dequeueFooter(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter) {
            return footer
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter)
    }

    func registerHeaderFooter(for tableView: UITableView) {
        if let nib = nibForHeader {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForHeader)
        }

        if let nib = nibForFooter {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForFooter)
        }
    }
}

#endif
