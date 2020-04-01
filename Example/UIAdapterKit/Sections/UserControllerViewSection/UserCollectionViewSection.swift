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

class UserStaticCollectionViewSection: StaticCollectionViewSection {
    private let headerTitle: String
    private let footerTitle: String
    
    init(items: [CollectionViewItem]) {
        let faker = Faker()
        headerTitle = faker.lorem.word()
        footerTitle = faker.lorem.word()
        
        super.init(items: items)
    }
    
    required init(instance: BaseCollectionViewSection) {
        let instance = instance as! UserStaticCollectionViewSection
        headerTitle = instance.headerTitle
        footerTitle = instance.footerTitle
        
        super.init(instance: instance)
    }
    
    override var nibForHeader: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    override var nibForFooter: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    override func configure(header: UICollectionReusableView) {
        (header as? UserCollectionViewHeaderFooter)?.titleLabel.text = headerTitle
    }
    
    override func configure(footer: UICollectionReusableView) {
        (footer as? UserCollectionViewHeaderFooter)?.titleLabel.text = footerTitle
    }
    
    override func sizeForHeader(_ container: Container) -> CGSize? {
        return CGSize(width: container.containerSize.width, height: 44)
    }
    
    override func sizeForFooter(_ container: Container) -> CGSize? {
        return sizeForHeader(container)
    }
}

class UserArrayCollectionViewSection: ArrayCollectionViewSection<User> {
    private let headerTitle: String
    private let footerTitle: String
    
    init(users: [User]) {
        let faker = Faker()
        headerTitle = faker.lorem.word()
        footerTitle = faker.lorem.word()
        
        super.init(items: users, itemBuilder: { UserCollectionViewItem(user: $0) })
    }
    
    required init(instance: BaseCollectionViewSection) {
        let instance = instance as! UserArrayCollectionViewSection
        headerTitle = instance.headerTitle
        footerTitle = instance.footerTitle
        
        super.init(instance: instance)
    }
    
    override var nibForHeader: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    override var nibForFooter: UINib? {
        return UINib(resource: R.nib.userCollectionViewHeaderFooter)
    }
    
    override func configure(header: UICollectionReusableView) {
        (header as? UserCollectionViewHeaderFooter)?.titleLabel.text = headerTitle
    }
    
    override func configure(footer: UICollectionReusableView) {
        (footer as? UserCollectionViewHeaderFooter)?.titleLabel.text = footerTitle
    }
    
    override func sizeForHeader(_ container: Container) -> CGSize? {
        return CGSize(width: container.containerSize.width, height: 44)
    }
    
    override func sizeForFooter(_ container: Container) -> CGSize? {
        return sizeForHeader(container)
    }
    
    override func filter(item: User, with payload: Any) -> Bool {
        if let string = payload as? String {
            return item.firstName.contains(string) ||
                item.lastName.contains(string) ||
                item.text.contains(string)
        }
        
        return super.filter(item: item, with: payload)
    }
}
