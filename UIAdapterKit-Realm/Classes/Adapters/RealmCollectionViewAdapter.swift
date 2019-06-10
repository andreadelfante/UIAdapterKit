//
//  RealmCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 09/06/2019.
//

import RealmSwift

open class RealmCollectionViewAdapter: BaseCollectionViewAdapter {
    public private(set) var itemsCount: Int
    
    private var sections: [Int: CollectionViewSection]
    private let itemAnimation: CollectionViewAnimation
    
    public init(animation: CollectionViewAnimation = .none) {
        sections = [:]
        itemsCount = 0
        itemAnimation = animation
    }
    
    deinit {
        sections.forEach {
            ($0.value as? RealmCollectionViewSection)?
                .notificationToken?
                .invalidate()
        }
    }
    
    open override var sectionCount: Int {
        return sections.count
    }
    
    open override func section(for index: Int) -> Section? {
        return sections[index]
    }
    
    public var hasItems: Bool {
        return itemsCount > 0
    }
    
    @discardableResult
    public func map<T: Object>(section: RealmCollectionViewSection<T>) -> Self {
        return map(index: sections.count, for: section)
    }
    
    @discardableResult
    public func map<T: Object>(index: Int, for section: RealmCollectionViewSection<T>) -> Self {
        delete(index: index)
        
        sections[index] = section
        itemsCount += section.count
        
        section.notificationToken = section.results.observe({ (change) in
            switch change {
            case .initial(_):
                section.onInitial()
                self.collectionView?.reloadData()
                break
                
            case .update(_, let deletions, let insertions, let modifications):
                self.itemsCount -= deletions.count
                self.itemsCount += insertions.count
                section.onUpdate()
                
                switch self.itemAnimation {
                case .none:
                    self.collectionView?.reloadData()
                case .section:
                    self.collectionView?.reloadSections([index])
                case .row:
                    self.collectionView?.performBatchUpdates({
                        self.collectionView?.deleteItems(at: deletions.map { IndexPath(row: $0, section: index) })
                        self.collectionView?.insertItems(at: insertions.map { IndexPath(row: $0, section: index) })
                        self.collectionView?.reloadItems(at: modifications.map { IndexPath(row: $0, section: index) })
                    })
                }
                break
                
            case .error(let error):
                section.onError(error)
                break
            }
        })
        return self
    }
    
    public func delete(index: Int) {
        if let section = sections.removeValue(forKey: index) as? RealmCollectionViewSection {
            itemsCount -= section.count
            
            switch itemAnimation {
            case .none:
                collectionView?.reloadData()
            case .section, .row:
                collectionView?.deleteSections([index])
            }
            
            section.notificationToken?.invalidate()
        }
    }
}
