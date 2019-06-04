//
//  StaticCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

open class StaticCollectionViewAdapter: BaseCollectionViewAdapter {
    private var sections: [CollectionViewSection]
    
    public init(sections: [CollectionViewSection]) {
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
