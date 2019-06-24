//
//  RealmTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 08/06/2019.
//

import RealmSwift

open class RealmTableViewSection<T: Object>: NSObject, TableViewSection, Copyable {
    public internal(set) var results: Results<T>
    internal var notificationToken: NotificationToken?
    public let itemBuilder: (T) -> RealmTableViewItem

    public var headerTitle: String?
    public var footerTitle: String?

    private var headerHeight: CGFloat?
    private var footerHeight: CGFloat?

    public init(headerTitle: String? = nil,
                footerTitle: String? = nil,
                headerHeight: CGFloat? = nil,
                footerHeight: CGFloat? = nil,
                results: Results<T>,
                itemBuilder: @escaping (T) -> RealmTableViewItem) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.results = results
        self.itemBuilder = itemBuilder
    }

    public required init(instance: RealmTableViewSection<T>) {
        results = instance.results
        itemBuilder = instance.itemBuilder
        headerTitle = instance.headerTitle
        footerTitle = instance.footerTitle
        headerHeight = instance.headerHeight
        footerHeight = instance.footerHeight
    }

    deinit {
        notificationToken?.invalidate()
    }

    open override func copy() -> Any {
        return type(of: self).init(instance: self)
    }

    open func onInitial() {}

    open func onUpdate() {}

    open func onError(_ error: Error) {}

    open var count: Int {
        return results.count
    }

    open func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder(results[index])
    }

    open var nibForHeader: UINib? {
        return nil
    }

    open func configure(header: UITableViewHeaderFooterView) {

    }

    open func heightForHeader(_ container: Container) -> CGFloat? {
        return headerHeight
    }

    open var nibForFooter: UINib? {
        return nil
    }

    open func configure(footer: UITableViewHeaderFooterView) {

    }

    open func heightForFooter(_ container: Container) -> CGFloat? {
        return footerHeight
    }
}

extension RealmTableViewSection: RealmFilterableBridging {
    func performFilter(with payload: Any) {
        guard let filterable = self as? RealmFilterableSection else { return }
        guard let predicate = filterable.filter(with: payload) else { return }

        results = results.filter(predicate)
    }
}
