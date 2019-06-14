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

class UserTableViewItem: TableViewItem, RealmTableViewItem, EditableTableViewItem, ActionPerformableTableViewItem {
    private var user: User
    private var actionForDelete: (() -> Void)?
    
    init(user: User, actionForDelete: (() -> Void)? = nil) {
        self.user = user
        self.actionForDelete = actionForDelete
    }
    
    var registrationType: RegistrationType {
        return .nib(UINib(resource: R.nib.userTableViewItem))
    }
    
    func configure(cell: UITableViewCell) {
        (cell as! UserTableViewCell).titleLabel.text = user.text
    }
    
    var actions: [UITableViewRowAction] {
        return [
            UITableViewRowAction(style: .destructive, title: "Delete", handler: { (_, _) in
                self.actionForDelete?()
            })
        ]
    }
    
    func canPerform(action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
    func perform(action: Selector, withSender sender: Any?) {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            UIPasteboard.general.string = user.text
        }
    }
}
