//
//  ArrayTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class ArrayTableViewAdapter: BaseTableViewAdapter {
    public private(set) var itemsCount: Int
    internal var sections: [BaseTableViewSection]

    public override init() {
        sections = []
        itemsCount = 0
        super.init()
    }

    open override var sectionCount: Int {
        return sections.count
    }

    open override func section(for index: Int) -> Section? {
        guard 0 <= index && index < sectionCount else { return nil }
        return sections[index]
    }

    open func append<T>(section: ArrayTableViewSection<T>) {
        sections.append(section)
        itemsCount += section.count

        reloadData()
    }

    @discardableResult
    open func insert<T>(section: ArrayTableViewSection<T>, at index: Int) -> Bool {
        guard 0 <= index && index <= sectionCount else { return false }

        sections.insert(section, at: index)
        itemsCount += section.count

        reloadData()
        return true
    }

    @discardableResult
    open func replace<T>(section: ArrayTableViewSection<T>, at index: Int) -> Bool {
        guard 0 <= index && index < sectionCount else { return false }

        let removedSection = sections.remove(at: index)
        itemsCount -= removedSection.count

        sections.insert(section, at: index)
        itemsCount += section.count

        reloadData()
        return true
    }

    @discardableResult
    open func remove(at index: Int) -> Bool {
        guard 0 <= index && index < sectionCount else { return false }

        let removedSection = sections.remove(at: index)
        itemsCount -= removedSection.count

        reloadData()
        return true
    }

    open func removeAll() {
        sections.removeAll()
        itemsCount = 0

        reloadData()
    }

    public var hasItems: Bool {
        return itemsCount > 0
    }
}

#endif
