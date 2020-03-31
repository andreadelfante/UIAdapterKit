//
//  ArrayTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class ArrayTableViewSection<T: AnyObject>: BaseTableViewSection, FilterableSection {
    private var items: [T]
    private let itemBuilder: (T) -> TableViewItem

    public init(
        headerTitle: String? = nil,
        footerTitle: String? = nil,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil,
        items: [T],
        itemBuilder: @escaping (T) -> TableViewItem
    ) {
        self.items = items
        self.itemBuilder = itemBuilder

        super.init(headerTitle: headerTitle,
                   footerTitle: footerTitle,
                   headerHeight: headerHeight,
                   footerHeight: footerHeight)
    }

    public required init(instance: BaseTableViewSection) {
        let instance = instance as! ArrayTableViewSection<T>
        items = instance.items
        itemBuilder = instance.itemBuilder

        super.init(instance: instance)
    }

    open override var count: Int {
        return items.count
    }

    open override func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder(items[index])
    }

    open func filter(item: T, with payload: Any) -> Bool {
        return true
    }

    public func performFilter(with payload: Any) {
        items = items.filter({ self.filter(item: $0, with: payload) })
    }
}

#endif
