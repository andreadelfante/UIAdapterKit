//
//  UserTableViewSection.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 22/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIAdapterKit
import Fakery

class UserTableViewFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        contentView.backgroundColor = .white
    }
}

class UserStaticTableViewSection: StaticTableViewSection {
    init(items: [TableViewItem]) {
        super.init(headerTitle: Faker().lorem.word(),
                   headerHeight: 44,
                   items: items)
    }
    
    required init(instance: BaseTableViewSection) {
        super.init(instance: instance)
    }
    
    override var nibForFooter: UINib? {
        return UINib(resource: R.nib.userTableViewFooter)
    }
    
    override func configure(footer: UITableViewHeaderFooterView) {
        (footer as? UserTableViewFooter)?.titleLabel.text = Faker().lorem.word()
    }
}

class UserArrayTableViewSection: ArrayTableViewSection<User> {
    init(users: [User]) {
        super.init(headerTitle: Faker().lorem.word(),
                   headerHeight: 44,
                   items: users,
                   itemBuilder: { UserTableViewItem(user: $0) })
    }
    
    required init(instance: BaseTableViewSection) {
        super.init(instance: instance)
    }
    
    override var nibForFooter: UINib? {
        return UINib(resource: R.nib.userTableViewFooter)
    }
    
    override func configure(footer: UITableViewHeaderFooterView) {
        (footer as? UserTableViewFooter)?.titleLabel.text = Faker().lorem.word()
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
