//
//  StaticTableViewController.swift
//  UIAdapterKit_Example
//
//  Created by Andrea Del Fante on 04/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UIAdapterKit

class StaticTableViewController: UITableViewController {
    
    private let adapter = StaticTableViewAdapter(sections: [
        UserTableViewSection(items: User.fake(10).map {
            UserTableViewItem(user: $0)
        }),
        UserTableViewSection(items: User.fake(10).map {
            UserTableViewItem(user: $0)
        })
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.tableView = tableView
    }
}

