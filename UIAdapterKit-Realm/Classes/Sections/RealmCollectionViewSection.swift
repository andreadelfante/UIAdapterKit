//
//  RealmCollectionViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 09/06/2019.
//

import RealmSwift

open class RealmCollectionViewSection<T: Object>: CollectionViewSection {
    internal var results: Results<T>
    internal var notificationToken: NotificationToken?
    public let itemBuilder: (T) -> RealmCollectionViewItem
    
    public init(results: Results<T>, itemBuilder: @escaping (T) -> RealmCollectionViewItem) {
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
    
    open func configure(header: UICollectionReusableView) {
        
    }
    
    open func sizeForHeader(_ container: Container) -> CGSize? {
        return nil
    }
    
    open var nibForFooter: UINib? {
        return nil
    }
    
    open func configure(footer: UICollectionReusableView) {
        
    }
    
    open func sizeForFooter(_ container: Container) -> CGSize? {
        return nil
    }
    
    open func minimumLineSpacing(_ container: Container) -> CGFloat? {
        return nil
    }
    
    open func minimumInteritemSpacing(_ container: Container) -> CGFloat? {
        return nil
    }
}
