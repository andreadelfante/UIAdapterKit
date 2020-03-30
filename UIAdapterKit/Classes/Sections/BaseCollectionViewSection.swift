//
//  BaseCollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 30/03/2020.
//

import Foundation
import UIKit

open class BaseCollectionViewSection: NSObject, Section, Copyable {
    private let _headerSize: CGSize?
    private let _footerSize: CGSize?
    private let _minimumLineSpacing: CGFloat?
    private let _minimumInteritemSpacing: CGFloat?
    
    internal init(
        headerSize: CGSize? = nil,
        footerSize: CGSize? = nil,
        minimumLineSpacing: CGFloat? = nil,
        minimumInteritemSpacing: CGFloat? = nil
    ) {
        self._headerSize = headerSize
        self._footerSize = footerSize
        self._minimumLineSpacing = minimumLineSpacing
        self._minimumInteritemSpacing = minimumInteritemSpacing
    }
    
    public required init(instance: BaseCollectionViewSection) {
        _headerSize = instance._headerSize
        _footerSize = instance._footerSize
        _minimumLineSpacing = instance._minimumLineSpacing
        _minimumInteritemSpacing = instance._minimumInteritemSpacing
    }
    
    public override func copy() -> Any {
        return type(of: self).init(instance: self)
    }
    
    public var count: Int {
        fatalError("Must override")
    }
    
    public func item(for index: Int) -> Item? {
        fatalError("Must override")
    }
    
    open func configure(header: UICollectionReusableView) {
    }
    
    open func configure(footer: UICollectionReusableView) {
    }

    open func sizeForHeader(_ container: Container) -> CGSize? {
        return _headerSize
    }
    
    open func sizeForFooter(_ container: Container) -> CGSize? {
        return _footerSize
    }

    open func minimumInteritemSpacing(_ container: Container) -> CGFloat? {
        return _minimumInteritemSpacing
    }
    
    open func minimumLineSpacing(_ container: Container) -> CGFloat? {
        return _minimumLineSpacing
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
