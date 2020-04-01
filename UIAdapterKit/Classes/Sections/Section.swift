//
//  Section.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

public protocol Section: Identifiable {
    var count: Int { get }
    var isEmpty: Bool { get }

    func item(for index: Int) -> Item?

    var nibForHeader: UINib? { get }
    var reuseIdentifierForHeader: String { get }

    var nibForFooter: UINib? { get }
    var reuseIdentifierForFooter: String { get }

    func didEndDisplayingHeader()
    func didEndDisplayingFooter()
}

public extension Section {
    var isEmpty: Bool { return count == 0 }
}

#endif
