//
//  StaticCollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class StaticCollectionViewSection: BaseCollectionViewSection {
    internal var items: [CollectionViewItem] = []

    public init(
        headerSize: CGSize? = nil,
        footerSize: CGSize? = nil,
        minimumLineSpacing: CGFloat? = nil,
        minimumInteritemSpacing: CGFloat? = nil,
        items: [CollectionViewItem]
    ) {
        self.items = items
        super.init(headerSize: headerSize,
                   footerSize: footerSize,
                   minimumLineSpacing: minimumLineSpacing,
                   minimumInteritemSpacing: minimumInteritemSpacing)
    }

    public required init(instance: BaseCollectionViewSection) {
        let instance = instance as! StaticCollectionViewSection
        items = instance.items

        super.init(instance: instance)
    }

    open override var count: Int {
        return items.count
    }

    open override func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return items[index]
    }
}

#endif
