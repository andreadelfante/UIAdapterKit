//
//  RealmCollectionViewSection.swift
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

open class RealmCollectionViewSection<T: Object>: BaseCollectionViewSection, RealmFilterableSection {
    public internal(set) var results: Results<T>!
    internal var notificationToken: NotificationToken?
    private var itemBuilder: ((T) -> CollectionViewItem)!

    public init(headerSize: CGSize? = nil,
                footerSize: CGSize? = nil,
                minimumLineSpacing: CGFloat? = nil,
                minimumInteritemSpacing: CGFloat? = nil,
                results: Results<T>,
                itemBuilder: @escaping (T) -> CollectionViewItem) {
        self.results = results
        self.itemBuilder = itemBuilder

        super.init(headerSize: headerSize,
                   footerSize: footerSize,
                   minimumLineSpacing: minimumLineSpacing,
                   minimumInteritemSpacing: minimumInteritemSpacing)
    }

    public required init(instance: BaseCollectionViewSection) {
        let instance = instance as! RealmCollectionViewSection<T>
        results = instance.results
        itemBuilder = instance.itemBuilder

        super.init(instance: instance)
    }

    deinit {
        notificationToken?.invalidate()
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

    open func filter(with payload: Any) -> NSPredicate? {
        return nil
    }

    public func performFilter(with payload: Any) {
        guard let predicate = filter(with: payload) else { return }

        results = results.filter(predicate)
    }
}

#endif
