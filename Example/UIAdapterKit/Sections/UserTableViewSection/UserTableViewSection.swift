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

class UserTableViewSection: TableViewSection {
    private let items: [TableViewItem]
    let headerTitle: String?
    
    init(items: [TableViewItem]) {
        self.items = items
        self.headerTitle = Faker().lorem.word()
    }
    
    var count: Int {
        return items.count
    }
    
    func item(for index: Int) -> Item? {
        return items[index]
    }
    
    var nibForFooter: UINib? {
        return UINib(resource: R.nib.userTableViewFooter)
    }
    
    func configure(footer: UITableViewHeaderFooterView) {
        (footer as? UserTableViewFooter)?.titleLabel.text = Faker().lorem.word()
    }
    
    func heightForFooter(_ container: Container) -> CGFloat? {
        return 44
    }
}
