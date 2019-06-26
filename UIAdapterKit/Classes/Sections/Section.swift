//
//  Section.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

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

    var nibForHeader: UINib? { return nil }

    var reuseIdentifierForHeader: String { return "\(identifier(self)).Header" }

    var nibForFooter: UINib? { return nil }

    var reuseIdentifierForFooter: String { return "\(identifier(self)).Footer" }

    func didEndDisplayingHeader() {}

    func didEndDisplayingFooter() {}
}
