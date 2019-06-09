//
//  RealmTableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 08/06/2019.
//

import RealmSwift

open class RealmTableViewSection<T: Object>: TableViewSection {
    internal var results: Results<T>
    internal var notificationToken: NotificationToken?
    public let itemBuilder: (T) -> RealmTableViewItem
    
    public var headerTitle: String?
    public var footerTitle: String?
    
    public init(headerTitle: String? = nil,
                footerTitle: String? = nil,
                results: Results<T>,
                itemBuilder: @escaping (T) -> RealmTableViewItem) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.results = results
        self.itemBuilder = itemBuilder
    }
    
    open func onInitial() {}
    
    open func onUpdate() {}
    
    open func onError(_ error: Error) {}
    
    open var count: Int {
        return results.count
    }
    
    open func item(for index: Int) -> Item? {
        guard 0 <= index && index < count else { return nil }
        return itemBuilder(results[index])
    }
    
    open var nibForHeader: UINib? {
        return nil
    }
    
    open func configure(header: UITableViewHeaderFooterView) {
        
    }
    
    open var nibForFooter: UINib? {
        return nil
    }
    
    open func configure(footer: UITableViewHeaderFooterView) {
        
    }
}