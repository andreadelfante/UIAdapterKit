//
//  RealmTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 08/06/2019.
//

#if canImport(UIKit)

import UIKit
import RealmSwift

#if SWIFT_PACKAGE
import UIAdapterKit
#endif

open class RealmTableViewAdapter: BaseTableViewAdapter {
    public private(set) var itemsCount: Int

    internal var sections: [Int: BaseTableViewSection]
    private var animation: TableViewAnimation

    public init(animation: TableViewAnimation = .none) {
        self.sections = [:]
        self.itemsCount = 0
        self.animation = animation
    }

    open var rowAnimation: TableViewAnimation {
        return animation
    }

    open override var sectionCount: Int {
        return sections.count
    }

    open override func section(for index: Int) -> Section? {
        return sections[index]
    }

    public var hasItems: Bool {
        return itemsCount > 0
    }

    @discardableResult
    public func map<T: Object>(section: RealmTableViewSection<T>) -> Self {
        return map(index: sections.count, for: section)
    }

    @discardableResult
    open func map<T: Object>(index: Int, for section: RealmTableViewSection<T>) -> Self {
        delete(index: index)

        sections[index] = section
        itemsCount += section.count

        section.notificationToken = section.results.observe({ [weak self] (change) in
            guard let strongSelf = self else { return }

            switch change {
            case .initial:
                section.onPreInitial()
                strongSelf.tableView?.reloadData()
                section.onPostInitial()

            case .update(_, let deletions, let insertions, let modifications):
                strongSelf.itemsCount -= deletions.count
                strongSelf.itemsCount += insertions.count
                section.onPreUpdate(deletions: deletions, insertions: insertions, modifications: modifications)

                switch strongSelf.rowAnimation {
                case .none:
                    strongSelf.tableView?.reloadData()
                case .section(let animation):
                    strongSelf.tableView?.reloadSections([index], with: animation)
                case .row(let animation):
                    strongSelf.tableView?.beginUpdates()
                    strongSelf.tableView?.deleteRows(at: deletions.map { IndexPath(row: $0, section: index) }, with: animation)
                    strongSelf.tableView?.insertRows(at: insertions.map { IndexPath(row: $0, section: index) }, with: animation)
                    strongSelf.tableView?.reloadRows(at: modifications.map { IndexPath(row: $0, section: index) }, with: animation)
                    strongSelf.tableView?.endUpdates()
                }

                section.onPostUpdate(deletions: deletions, insertions: insertions, modifications: modifications)

            case .error(let error):
                section.onError(error)
            }
        })

        return self
    }

    open func delete(index: Int) {
        if let section = sections.removeValue(forKey: index) {
            itemsCount -= section.count

            switch self.rowAnimation {
            case .none:
                tableView?.reloadData()
            case .row(let animation), .section(let animation):
                tableView?.deleteSections([index], with: animation)
            }
        }
    }

    open func deleteAll() {
        sections.keys.forEach { self.delete(index: $0) }
    }
}

#endif
