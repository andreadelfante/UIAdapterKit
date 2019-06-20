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
import PredicateFlow

class RealmUserCollectionViewSection: RealmCollectionViewSection<User>, RealmFilterableSection {
    init(realm: Realm) {
        super.init(results: realm.objects(User.self).sorted(UserSchema.lastName.ascending()),
                   itemBuilder: { UserCollectionViewItem(user: $0) })
    }
    
    required init(instance: RealmCollectionViewSection<User>) {
        super.init(instance: instance)
    }
    
    func filter(with payload: Any) -> NSPredicate? {
        if let string = payload as? String {
            return PredicateBuilder(UserSchema.firstName.contains(string))
                .or(UserSchema.lastName.contains(string))
                .or(UserSchema.text.contains(string))
                .build()
        }
        return nil
    }
}

class RealmCollectionViewController: UICollectionViewController {
    private var realm: Realm!
    private var adapter: RealmSearchableCollectionViewAdapter!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: NSStringFromClass(RealmCollectionViewController.self)))
        
        searchBar.delegate = self
        collectionView?.addSubview(searchBar)
        
        adapter = RealmSearchableCollectionViewAdapter(animation: .row)
            .map(section: RealmUserCollectionViewSection(realm: realm))
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

extension RealmCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adapter.filterPayload = searchText.isEmpty ? nil : searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
