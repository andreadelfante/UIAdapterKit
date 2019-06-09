//
//  UserTableViewItem.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 21/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIAdapterKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class UserTableViewItem: TableViewItem, RealmTableViewItem {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var registrationType: RegistrationType {
        return .nib(UINib(resource: R.nib.userTableViewItem))
    }
    
    func configure(cell: UITableViewCell) {
        (cell as! UserTableViewCell).titleLabel.text = user.text
    }
}
