//
//  RealmCollectionViewController.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 09/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit
import RealmSwift

class RealmCollectionViewController: UICollectionViewController {
    private var realm: Realm!
    private var adapter: RealmCollectionViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: NSStringFromClass(RealmCollectionViewController.self)))
        
        adapter = RealmCollectionViewAdapter(animation: true)
            .map(section: RealmCollectionViewSection(results: realm.objects(User.self).sorted(byKeyPath: "lastName"),
                                                     itemBuilder: { UserCollectionViewItem(user: $0) }))
        adapter.collectionView = collectionView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        try! realm.write {
            realm.add(User.fake(50))
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            try! self.realm.write {
                self.realm.add(User.fake(50))
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        try! realm.write {
            realm.deleteAll()
        }
        
        super.viewDidDisappear(animated)
    }
}
