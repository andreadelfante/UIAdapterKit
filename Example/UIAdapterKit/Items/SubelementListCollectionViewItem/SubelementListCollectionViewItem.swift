//
//  SubelementListCollectionViewItem.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 25/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit

class SubelementListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}

struct SubelementListCollectionViewItem: CollectionViewItem {
    let subelementList: SubelementList
    
    func configure(cell: UICollectionViewCell) {
        let cell = cell as! SubelementListCollectionViewCell
        
        cell.label.text = subelementList.word
    }
    
    func size(_ container: Container) -> CGSize? {
        return CGSize(width: CGFloat(16 + (subelementList.word.count * 8)),
                      height: container.containerSize.height)
    }
}
