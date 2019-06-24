//
//  TableViewAnimation.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 10/06/2019.
//

public enum TableViewAnimation: Equatable {
    case none
    case section(_ animation: UITableView.RowAnimation)
    case row(_ animation: UITableView.RowAnimation)

    public static func ==(lhs: TableViewAnimation, rhs: TableViewAnimation) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.section(let lhs), .section(let rhs)):
            return lhs == rhs
        case (.row(let lhs), .row(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
