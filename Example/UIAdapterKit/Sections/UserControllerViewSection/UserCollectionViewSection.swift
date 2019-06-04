//
//  UserCollectionViewSection.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 03/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIAdapterKit
import Fakery

class UserCollectionViewHeaderFooter: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
}

class UserCollectionViewSection: CollectionViewSection {
    
    private let items: [CollectionViewItem]
    private let headerTitle: String
    private let footerTitle: String
    
    init(items: [CollectionViewItem]) {
        self.items = items
        
        let faker = Faker()
        headerTitle = faker.lorem.word()
        footerTitle = faker.lorem.word()
    }
    
    var count: Int {
        return items.count
    }
    
    func item(for index: Int) -> Item? {
        return items[index]
    }
    
    var nibForHeader: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    var nibForFooter: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    func configure(header: UICollectionReusableView) {
        (header as? UserCollectionViewHeaderFooter)?.titleLabel.text = headerTitle
    }
    
    func configure(footer: UICollectionReusableView) {
        (footer as? UserCollectionViewHeaderFooter)?.titleLabel.text = footerTitle
    }
    
    func sizeForHeader(_ container: Container) -> CGSize? {
        return CGSize(width: container.containerSize.width, height: 44)
    }
    
    func sizeForFooter(_ container: Container) -> CGSize? {
        return sizeForHeader(container)
    }
}
