//
//  UserCollectionViewItem.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 03/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIAdapterKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class UserCollectionViewItem: CollectionViewItem, ActionPerformableCollectionViewItem {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var registrationType: RegistrationType {
        return .nib(UINib(resource: R.nib.userCollectionViewItem))
    }
    
    func configure(cell: UICollectionViewCell) {
        (cell as! UserCollectionViewCell).titleLabel.text = user.firstName
    }
    
    func size(_ container: Container) -> CGSize? {
        return CGSize(width: container.containerSize.width / 4, height: container.containerSize.height / 4)
    }
    
    func canPerform(action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
    func perform(action: Selector, withSender sender: Any?) {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            UIPasteboard.general.string = user.firstName
        }
    }
}
