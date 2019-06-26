//
//  ElementListTableViewItem.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 25/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit

class ElementListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
}

struct ElementListTableViewItem: RealmTableViewItem {
    let elementList: ElementList
    let adapter = RealmCollectionViewAdapter(animation: .row)
    
    func configure(cell: UITableViewCell) {
        let cell = cell as! ElementListTableViewCell
        
        cell.titleLabel.text = elementList.title
        
        adapter.deleteAll()
        adapter.map(section: RealmCollectionViewSection(minimumLineSpacing: 0,
                                                        minimumInteritemSpacing: 0,
                                                        results: elementList.sortedElements,
                                                        itemBuilder: itemBuilder))
        adapter.collectionView = cell.collectionView
    }
    
    private func itemBuilder(subelementList: SubelementList) -> SubelementListCollectionViewItem {
        return SubelementListCollectionViewItem(subelementList: subelementList)
    }
}
