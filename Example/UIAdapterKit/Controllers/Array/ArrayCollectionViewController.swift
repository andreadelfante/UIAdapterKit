//
//  ArrayCollectionViewController.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 31/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit

class ArrayCollectionViewController: UICollectionViewController {
    private let adapter: ArraySearchableCollectionViewAdapter = ArraySearchableCollectionViewAdapter()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        collectionView?.addSubview(searchBar)
        
        adapter.append(section: section(users: User.fake(3)))
        adapter.append(section: section(users: User.fake(2)))
        adapter.append(section: section(users: User.fake(5)))
        adapter.collectionView = collectionView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.adapter.append(section: self.section(users: User.fake(20)))
            self.adapter.replace(section: self.section(users: User.fake(10)), at: 0)
            self.adapter.remove(at: self.adapter.sectionCount - 1)
        }
    }
    
    private func section(users: [User]) -> ArrayCollectionViewSection<User> {
        return UserArrayCollectionViewSection(users: users)
    }
}

extension ArrayCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adapter.filter(with: searchText.isEmpty ? nil : searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
