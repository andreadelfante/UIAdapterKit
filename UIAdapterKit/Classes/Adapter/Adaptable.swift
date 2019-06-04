//
//  Adaptable.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

public protocol Adaptable {
    var sectionCount: Int { get }
    var hasSections: Bool { get }
    
    func section(for index: Int) -> Section?
}

public extension Adaptable {
    var hasSections: Bool { return sectionCount > 0 }
}
