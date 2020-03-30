//
//  RealmTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 08/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit
import RealmSwift

#if SWIFT_PACKAGE
import UIAdapterKit
#endif

open class RealmTableViewSection<T: Object>: BaseTableViewSection {
    public internal(set) var results: Results<T>!
    internal var notificationToken: NotificationToken?
    private var itemBuilder: ((T) -> TableViewItem)!

    public init(headerTitle: String? = nil,
                footerTitle: String? = nil,
                headerHeight: CGFloat? = nil,
                footerHeight: CGFloat? = nil,
                results: Results<T>,
                itemBuilder: @escaping (T) -> TableViewItem) {
        self.results = results
        self.itemBuilder = itemBuilder
        
        super.init(headerTitle: headerTitle,
                   footerTitle: footerTitle,
                   headerHeight: headerHeight,
                   footerHeight: footerHeight)
    }

    public required init(instance: BaseTableViewSection) {
        super.init(instance: instance)
        
        if let instance = instance as? RealmTableViewSection<T> {
            results = instance.results
            itemBuilder = instance.itemBuilder
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    open override func copy() -> Any {
        return type(of: self).init(instance: self)
    }

    open override var count: Int {
        return results.count
    }

    open override func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder(results[index])
    }
    
    open func onPreInitial() {}

    open func onPostInitial() {}

    open func onPreUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {}

    open func onPostUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {}

    open func onError(_ error: Error) {}
}

extension RealmTableViewSection: RealmFilterableBridging {
    func performFilter(with payload: Any) {
        guard let filterable = self as? RealmFilterableSection else { return }
        guard let predicate = filterable.filter(with: payload) else { return }

        results = results.filter(predicate)
    }
}

#endif
