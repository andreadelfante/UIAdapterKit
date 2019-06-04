//
//  StaticCollectionViewController.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit

class StaticCollectionViewController: UICollectionViewController {
    
    private let adapter = StaticCollectionViewAdapter(sections: [
        UserCollectionViewSection(items: User.fake(10).map { UserCollectionViewItem(user: $0) }),
        UserCollectionViewSection(items: User.fake(10).map { UserCollectionViewItem(user: $0) })
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = collectionView
    }
}
