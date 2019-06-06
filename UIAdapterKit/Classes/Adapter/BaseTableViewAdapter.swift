//
//  BaseTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

open class BaseTableViewAdapter: NSObject, Adaptable, UITableViewDelegate, UITableViewDataSource {

    open var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }

    open func reloadData() {
        tableView?.reloadData()
    }

    // MARK: Adaptable

    open var sectionCount: Int {
        fatalError("Must override")
    }

    open func section(for index: Int) -> Section? {
        fatalError("Must override")
    }

    // MARK: UITableViewDelegate, UITableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(for: section)?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(for: indexPath)!
        let cell = item.dequeueCell(from: tableView, at: indexPath)

        item.configure(cell: cell)
        return cell
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return self.item(for: indexPath)?.didSelectItem != nil
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didSelectItem?()
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didDeselectItem?()
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.item(for: indexPath)?.height(tableView) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSection(for: section)?.headerTitle
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard let header = section.dequeueHeader(for: tableView) else { return nil }

        section.configure(header: header)
        return header
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSection(for: section)?.heightForHeader(tableView) ?? UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableViewSection(for: section)?.footerTitle
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard let footer = section.dequeueFooter(for: tableView) else { return nil }

        section.configure(footer: footer)
        return footer
    }
}

fileprivate extension Adaptable where Self: BaseTableViewAdapter {
    func tableViewSection(for index: Int) -> TableViewSection? {
        return section(for: index) as? TableViewSection
    }

    func item(for indexPath: IndexPath) -> TableViewItem? {
        return section(for: indexPath.section)?
            .item(for: indexPath.row) as? TableViewItem
    }
}
