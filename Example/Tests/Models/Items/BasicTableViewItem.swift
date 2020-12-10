//
//  BasicTableViewItem.swift
//  UIAdapterKit_Tests
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

@testable import UIAdapterKit

class BasicTableViewItem: TableViewItem {
    private var model: BasicModel
    
    init(_ model: BasicModel) {
        self.model = model
    }
    
    func configure(cell: UITableViewCell) {
        cell.textLabel?.text = model.text
        cell.detailTextLabel?.text = model.detail
    }
}

#endif
