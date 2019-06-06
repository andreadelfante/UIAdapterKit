//
//  TableViewSection.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

public protocol TableViewSection: Section {
    var headerTitle: String? { get }
    var footerTitle: String? { get }

    func configure(header: UITableViewHeaderFooterView)
    func configure(footer: UITableViewHeaderFooterView)

    func heightForHeader(_ container: Container) -> CGFloat?
    func heightForFooter(_ container: Container) -> CGFloat?
}

public extension TableViewSection {
    var headerTitle: String? { return nil }

    var footerTitle: String? { return nil }

    func configure(header: UITableViewHeaderFooterView) {}

    func configure(footer: UITableViewHeaderFooterView) {}

    func heightForHeader(_ container: Container) -> CGFloat? { return nil }

    func heightForFooter(_ container: Container) -> CGFloat? { return nil }
}

public extension TableViewSection {
    func dequeueHeader(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader) {
            return header
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForHeader)
    }

    func dequeueFooter(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        if let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter) {
            return footer
        }

        registerHeaderFooter(for: tableView)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifierForFooter)
    }

    func registerHeaderFooter(for tableView: UITableView) {
        if let nib = nibForHeader {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForHeader)
        }

        if let nib = nibForFooter {
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifierForFooter)
        }
    }
}
