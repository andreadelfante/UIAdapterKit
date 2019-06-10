//
//  RealmTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 08/06/2019.
//

import RealmSwift

open class RealmTableViewAdapter: BaseTableViewAdapter {
    public private(set) var itemsCount: Int
    
    private var sections: [Int: TableViewSection]
    private let rowAnimation: TableViewAnimation
    
    public init(animation: TableViewAnimation = .none) {
        sections = [:]
        itemsCount = 0
        rowAnimation = animation
    }
    
    deinit {
        sections.forEach {
            ($0.value as? RealmTableViewSection)?
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
    public func map<T: Object>(section: RealmTableViewSection<T>) -> Self {
        return map(index: sections.count, for: section)
    }
    
    @discardableResult
    public func map<T: Object>(index: Int, for section: RealmTableViewSection<T>) -> Self {
        delete(index: index)
        
        sections[index] = section
        itemsCount += section.count
        
        section.notificationToken = section.results.observe({ (change) in
            switch change {
            case .initial(_):
                section.onInitial()
                self.tableView?.reloadData()
                break
                
            case .update(_, let deletions, let insertions, let modifications):
                self.itemsCount -= deletions.count
                self.itemsCount += insertions.count
                section.onUpdate()
                
                switch self.rowAnimation {
                case .none:
                    self.tableView?.reloadData()
                case .section(let animation):
                    self.tableView?.reloadSections([index], with: animation)
                case .row(let animation):
                    self.tableView?.beginUpdates()
                    self.tableView?.deleteRows(at: deletions.map { IndexPath(row: $0, section: index) }, with: animation)
                    self.tableView?.insertRows(at: insertions.map { IndexPath(row: $0, section: index) }, with: animation)
                    self.tableView?.reloadRows(at: modifications.map { IndexPath(row: $0, section: index) }, with: animation)
                    self.tableView?.endUpdates()
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
        if let section = sections.removeValue(forKey: index) as? RealmTableViewSection {
            itemsCount -= section.count
            
            switch self.rowAnimation {
            case .none:
                tableView?.reloadData()
            case .row(let animation), .section(let animation):
                tableView?.deleteSections([index], with: animation)
            }
            
            section.notificationToken?.invalidate()
        }
    }
}
