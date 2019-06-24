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

    open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(for: section)?.count ?? 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(for: indexPath)!
        let cell = item.dequeueCell(from: tableView, at: indexPath)

        item.configure(cell: cell)
        return cell
    }

    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return self.item(for: indexPath)?.didSelectItem != nil
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didSelectItem?()
    }

    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didDeselectItem?()
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.item(for: indexPath)?.height(tableView) ?? UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        return section.headerTitle
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        guard let header = section.dequeueHeader(for: tableView) else { return nil }

        section.configure(header: header)
        return header
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = tableViewSection(for: section) else { return 0.1 }
        guard !section.isEmpty else { return 0.1 }
        return section.heightForHeader(tableView) ?? UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        return section.footerTitle
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        guard let footer = section.dequeueFooter(for: tableView) else { return nil }

        section.configure(footer: footer)
        return footer
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = tableViewSection(for: section) else { return 0.1 }
        guard !section.isEmpty else { return 0.1 }
        return section.heightForFooter(tableView) ?? UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return (item(for: indexPath) as? EditableTableViewItem)?.actions
    }

    open func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return item(for: indexPath) is ActionPerformableTableViewItem
    }

    open func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return (item(for: indexPath) as? ActionPerformableTableViewItem)?.canPerform(action: action, withSender: sender) ?? false
    }

    open func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        (item(for: indexPath) as? ActionPerformableTableViewItem)?.perform(action: action, withSender: sender)
    }

    open func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return item(for: indexPath)?.indentationLevel ?? 1
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
