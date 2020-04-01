//
//  ArrayCollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class ArrayCollectionViewSection<T>: BaseCollectionViewSection, FilterableSection {
    private var items: [T]
    private let itemBuilder: (T) -> CollectionViewItem

    public init(
        headerSize: CGSize? = nil,
        footerSize: CGSize? = nil,
        minimumLineSpacing: CGFloat? = nil,
        minimumInteritemSpacing: CGFloat? = nil,
        items: [T],
        itemBuilder: @escaping (T) -> CollectionViewItem
    ) {
        self.items = items
        self.itemBuilder = itemBuilder

        super.init(headerSize: headerSize,
                   footerSize: footerSize,
                   minimumLineSpacing: minimumLineSpacing,
                   minimumInteritemSpacing: minimumInteritemSpacing)
    }

    public required init(instance: BaseCollectionViewSection) {
        let instance = instance as! ArrayCollectionViewSection<T> // swiftlint:disable:this force_cast
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
