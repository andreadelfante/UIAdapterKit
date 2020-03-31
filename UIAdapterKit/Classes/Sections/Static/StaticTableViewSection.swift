//
//  StaticTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class StaticTableViewSection: BaseTableViewSection {
    internal var items: [TableViewItem]

    public init(
        headerTitle: String? = nil,
        footerTitle: String? = nil,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil,
        items: [TableViewItem]
    ) {
        self.items = items
        super.init(headerTitle: headerTitle,
                   footerTitle: footerTitle,
                   headerHeight: headerHeight,
                   footerHeight: footerHeight)
    }

    public required init(instance: BaseTableViewSection) {
        let instance = instance as! StaticTableViewSection
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
