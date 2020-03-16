//
//  CollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

public protocol CollectionViewSection: Section {
    func configure(header: UICollectionReusableView)
    func configure(footer: UICollectionReusableView)

    func sizeForHeader(_ container: Container) -> CGSize?
    func sizeForFooter(_ container: Container) -> CGSize?

    func minimumInteritemSpacing(_ container: Container) -> CGFloat?
    func minimumLineSpacing(_ container: Container) -> CGFloat?

    func dequeueSupplementaryView(for collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView?
    func registerSupplementaryView(for collectionView: UICollectionView)
}

public extension CollectionViewSection {
    func configure(header: UICollectionReusableView) {}
    func configure(footer: UICollectionReusableView) {}

    func sizeForHeader(_ container: Container) -> CGSize? { return nil }
    func sizeForFooter(_ container: Container) -> CGSize? { return nil }

    func minimumInteritemSpacing(_ container: Container) -> CGFloat? { return nil }
    func minimumLineSpacing(_ container: Container) -> CGFloat? { return nil }
}

public extension CollectionViewSection {
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
