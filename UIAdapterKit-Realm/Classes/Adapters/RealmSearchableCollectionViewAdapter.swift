//
//  RealmSearchableCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 20/06/2019.
//

import RealmSwift

fileprivate typealias FilterableSection = NSObject & CollectionViewSection & RealmFilterableSection & RealmFilterableBridging

open class RealmSearchableCollectionViewAdapter: RealmCollectionViewAdapter {
    internal var filteredSections: [Int: CollectionViewSection]
    internal var filteredItemsCount: Int
    
    public private(set) var isSeeking: Bool
    
    public var filterPayload: Any? {
        didSet {
            filteredItemsCount = 0
            isSeeking = false
            filteredSections = [:]
            
            if let payload = filterPayload {
                isSeeking = true
                
                for keyValue in sections {
                    var section = keyValue.value
                    if var filterableSection = section as? FilterableSection {
                        filterableSection = filterableSection.copy() as! FilterableSection
                        filterableSection.performFilter(with: payload)
                        section = filterableSection
                    }
                    
                    filteredItemsCount += section.count
                    filteredSections[keyValue.key] = section
                }
            }
            
            reloadData()
        }
    }
    
    public override init(animation: CollectionViewAnimation = .none) {
        filteredSections = [:]
        filteredItemsCount = 0
        isSeeking = false
        super.init(animation: animation)
    }
    
    open override var itemAnimation: CollectionViewAnimation {
        return isSeeking ? .none : super.itemAnimation
    }
    
    public override var hasItems: Bool {
        return isSeeking ? filteredItemsCount > 0 : super.hasItems
    }
    
    open override var sectionCount: Int {
        return isSeeking ? filteredSections.count : super.sectionCount
    }
    
    open override func section(for index: Int) -> Section? {
        guard isSeeking else { return super.section(for: index) }
        guard 0 <= index && index < sectionCount else { return nil }
        return filteredSections[index]
    }
    
    @discardableResult
    open override func map<T>(index: Int, for section: RealmCollectionViewSection<T>) -> Self where T : Object {
        if !(section is RealmFilterableSection) {
            print("[WARNING] The section at index \(index) doesn't implement \(RealmFilterableSection.self). It will be ignored during filtering.")
        }
        
        super.map(index: index, for: section)
        return self
    }
}
