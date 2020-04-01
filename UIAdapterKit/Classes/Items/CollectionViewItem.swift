//
//  CollectionViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

public protocol CollectionViewItem: Item {
    func configure(cell: UICollectionViewCell)

    func willDisplay(cell: UICollectionViewCell)

    func size(_ container: Container) -> CGSize?
}

public extension CollectionViewItem {
    func willDisplay(cell: UICollectionViewCell) {}

    func size(_ container: Container) -> CGSize? { return nil }
}

public extension CollectionViewItem {
    func registerCell(for collectionView: UICollectionView) {
        switch registrationType {
        case .nib(let nib):
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        case .clazz(let clazz):
            collectionView.register(clazz, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }

    func dequeueCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        registerCell(for: collectionView)
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}

#endif
