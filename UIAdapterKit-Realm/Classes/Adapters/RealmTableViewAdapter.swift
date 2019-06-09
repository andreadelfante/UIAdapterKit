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
    private let rowAnimation: UITableView.RowAnimation?
    
    public init(animation: UITableView.RowAnimation? = nil) {
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
                
            case .update(_, let deletions, let insertions, _):
                self.itemsCount -= deletions.count
                self.itemsCount += insertions.count
                section.onUpdate()
                
                if let animation = self.rowAnimation {
                    self.tableView?.reloadSections([index], with: animation)
                } else {
                    self.tableView?.reloadData()
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
            
            if let animation = self.rowAnimation {
                tableView?.deleteSections([index], with: animation)
            } else {
                tableView?.reloadData()
            }
            
            section.notificationToken?.invalidate()
        }
    }
}
