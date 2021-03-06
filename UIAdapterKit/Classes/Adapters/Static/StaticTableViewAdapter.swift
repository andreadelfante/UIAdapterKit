//
//  StaticTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class StaticTableViewAdapter: BaseTableViewAdapter {
    private var sections: [StaticTableViewSection]

    public init(sections: [StaticTableViewSection]) {
        self.sections = sections
    }

    open override var sectionCount: Int {
        return sections.count
    }

    open override func section(for index: Int) -> Section? {
        guard 0 <= index && index < sectionCount else { return nil }
        return sections[index]
    }
}

#endif
