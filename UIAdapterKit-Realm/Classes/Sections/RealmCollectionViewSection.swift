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

open class RealmCollectionViewSection<T: Object>: NSObject, CollectionViewSection, Copyable {
    public internal(set) var results: Results<T>
    internal var notificationToken: NotificationToken?
    public let itemBuilder: (T) -> RealmCollectionViewItem

    private var headerSize: CGSize?
    private var footerSize: CGSize?
    private var minimumLineSpacing: CGFloat?
    private var minimumInteritemSpacing: CGFloat?

    public init(headerSize: CGSize? = nil,
                footerSize: CGSize? = nil,
                minimumLineSpacing: CGFloat? = nil,
                minimumInteritemSpacing: CGFloat? = nil,
                results: Results<T>,
                itemBuilder: @escaping (T) -> RealmCollectionViewItem) {
        self.results = results
        self.itemBuilder = itemBuilder
        self.headerSize = headerSize
        self.footerSize = footerSize
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }

    public required init(instance: RealmCollectionViewSection<T>) {
        results = instance.results
        itemBuilder = instance.itemBuilder
        headerSize = instance.headerSize
        footerSize = instance.footerSize
        minimumLineSpacing = instance.minimumLineSpacing
        minimumInteritemSpacing = instance.minimumInteritemSpacing
    }

    deinit {
        notificationToken?.invalidate()
    }

    open override func copy() -> Any {
        return type(of: self).init(instance: self)
    }

    open func onPreInitial() {}

    open func onPostInitial() {}

    open func onPreUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {}

    open func onPostUpdate(deletions: [Int], insertions: [Int], modifications: [Int]) {}

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

    open func configure(header: UICollectionReusableView) {

    }

    open func didEndDisplayingHeader() {

    }

    open func sizeForHeader(_ container: Container) -> CGSize? {
        return headerSize
    }

    open var nibForFooter: UINib? {
        return nil
    }

    open func configure(footer: UICollectionReusableView) {

    }

    open func didEndDisplayingFooter() {

    }

    open func sizeForFooter(_ container: Container) -> CGSize? {
        return footerSize
    }

    open func minimumLineSpacing(_ container: Container) -> CGFloat? {
        return minimumLineSpacing
    }

    open func minimumInteritemSpacing(_ container: Container) -> CGFloat? {
        return minimumInteritemSpacing
    }
}

extension RealmCollectionViewSection: RealmFilterableBridging {
    func performFilter(with payload: Any) {
        guard let filterable = self as? RealmFilterableSection else { return }
        guard let predicate = filterable.filter(with: payload) else { return }

        results = results.filter(predicate)
    }
}

#endif
