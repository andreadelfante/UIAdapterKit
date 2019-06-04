//
//  TableViewItem.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

public protocol TableViewItem: Item {
    func configure(cell: UITableViewCell)
    
    func height(_ container: Container) -> CGFloat?
}

public extension TableViewItem {
    func height(_ container: Container) -> CGFloat? { return nil }
}

public extension TableViewItem {
    func registerCell(for tableView: UITableView) {
        switch registrationType {
        case .nib(let nib):
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        case .clazz(let clazz):
            tableView.register(clazz, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        
        registerCell(for: tableView)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    }
}
