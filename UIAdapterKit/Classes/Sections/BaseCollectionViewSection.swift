//
//  BaseCollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 30/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class BaseCollectionViewSection: Section, Copyable {
    public let headerSize: CGSize?
    public let footerSize: CGSize?
    public let minimumLineSpacing: CGFloat?
    public let minimumInteritemSpacing: CGFloat?

    public init(
        headerSize: CGSize? = nil,
        footerSize: CGSize? = nil,
        minimumLineSpacing: CGFloat? = nil,
        minimumInteritemSpacing: CGFloat? = nil
    ) {
        self.headerSize = headerSize
        self.footerSize = footerSize
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }

    public required init(instance: BaseCollectionViewSection) {
        headerSize = instance.headerSize
        footerSize = instance.footerSize
        minimumLineSpacing = instance.minimumLineSpacing
        minimumInteritemSpacing = instance.minimumInteritemSpacing
    }

    open var count: Int {
        fatalError("Must override")
    }

    open func item(for index: Int) -> Item? {
        fatalError("Must override")
    }

    open var nibForHeader: UINib? {
        return nil
    }

    open var nibForFooter: UINib? {
        return nil
    }

    open var reuseIdentifierForHeader: String {
        return "\(identifier(self)).Header"
    }

    open var reuseIdentifierForFooter: String {
        return "\(identifier(self)).Footer"
    }

    open func configure(header: UICollectionReusableView) {
    }

    open func configure(footer: UICollectionReusableView) {
    }

    open func sizeForHeader(_ container: Container) -> CGSize? {
        return headerSize
    }

    open func sizeForFooter(_ container: Container) -> CGSize? {
        return footerSize
    }

    open func didEndDisplayingHeader() {
    }

    open func didEndDisplayingFooter() {
    }

    open func minimumInteritemSpacing(_ container: Container) -> CGFloat? {
        return minimumInteritemSpacing
    }

    open func minimumLineSpacing(_ container: Container) -> CGFloat? {
        return minimumLineSpacing
    }

    func dequeueSupplementaryView(for collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        registerSupplementaryView(for: collectionView)

        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForHeader, for: indexPath)
        }

        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForFooter, for: indexPath)
        }

        return nil
    }

    func registerSupplementaryView(for collectionView: UICollectionView) {
        if let nib = nibForHeader {
            collectionView.register(nib,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: reuseIdentifierForHeader)
        }

        if let nib = nibForFooter {
            collectionView.register(nib,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                    withReuseIdentifier: reuseIdentifierForFooter)
        }
    }
}

#endif
