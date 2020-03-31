//
//  RealmCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 09/06/2019.
//

#if canImport(UIKit)

import UIKit
import RealmSwift

#if SWIFT_PACKAGE
import UIAdapterKit
#endif

open class RealmCollectionViewAdapter: BaseCollectionViewAdapter {
    public private(set) var itemsCount: Int

    internal var sections: [Int: BaseCollectionViewSection]
    private var animation: CollectionViewAnimation

    public init(animation: CollectionViewAnimation = .none) {
        self.sections = [:]
        self.itemsCount = 0
        self.animation = animation
    }

    open var itemAnimation: CollectionViewAnimation {
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
    public func map<T: Object>(section: RealmCollectionViewSection<T>) -> Self {
        return map(index: sections.count, for: section)
    }

    @discardableResult
    open func map<T: Object>(index: Int, for section: RealmCollectionViewSection<T>) -> Self {
        delete(index: index)

        sections[index] = section
        itemsCount += section.count

        section.notificationToken = section.results.observe({ [weak self] (change) in
            guard let strongSelf = self else { return }

            switch change {
            case .initial:
                section.onPreInitial()
                strongSelf.collectionView?.reloadData()
                section.onPostInitial()

            case .update(_, let deletions, let insertions, let modifications):
                strongSelf.itemsCount -= deletions.count
                strongSelf.itemsCount += insertions.count
                section.onPreUpdate(deletions: deletions, insertions: insertions, modifications: modifications)

                switch strongSelf.itemAnimation {
                case .none:
                    strongSelf.collectionView?.reloadData()
                case .section:
                    strongSelf.collectionView?.reloadSections([index])
                case .row:
                    strongSelf.collectionView?.performBatchUpdates({
                        strongSelf.collectionView?.deleteItems(at: deletions.map { IndexPath(row: $0, section: index) })
                        strongSelf.collectionView?.insertItems(at: insertions.map { IndexPath(row: $0, section: index) })
                        strongSelf.collectionView?.reloadItems(at: modifications.map { IndexPath(row: $0, section: index) })
                    })
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

            switch itemAnimation {
            case .none:
                collectionView?.reloadData()
            case .section, .row:
                collectionView?.deleteSections([index])
            }
        }
    }

    open func deleteAll() {
        sections.keys.forEach { self.delete(index: $0) }
    }
}

#endif
