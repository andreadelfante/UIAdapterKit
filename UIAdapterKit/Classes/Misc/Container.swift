//
//  Container.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import UIKit

public protocol Container {
    var containerSize: CGRect { get }
}

extension UICollectionView: Container {
    public var containerSize: CGRect {
        return bounds
    }
}

extension UITableView: Container {
    public var containerSize: CGRect {
        return bounds
    }
}

#endif
