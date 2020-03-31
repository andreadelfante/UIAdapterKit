//
//  BaseTableViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

#if canImport(UIKit)

import Foundation
import UIKit

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
        guard let item = self.item(for: indexPath) else { return UITableViewCell() } // This is useful to avoid crash when there are multiple concurrent UITableView refresh.
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

	open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return self.tableView(tableView, heightForRowAt: indexPath)
	}

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.willDisplay(cell: cell)
    }

    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didEndDisplayingItem()
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        return section.titleForHeader
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

    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        tableViewSection(for: section)?.didEndDisplayingHeader()
    }

    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let section = tableViewSection(for: section) else { return nil }
        guard !section.isEmpty else { return nil }
        return section.titleForFooter
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

    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        tableViewSection(for: section)?.didEndDisplayingFooter()
    }

	open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		let item = self.item(for: indexPath)
		guard item is SwipeableTableViewItem || item is EditableTableViewItem else { return false }

		if let swipeable = item as? SwipeableTableViewItem {
			return !swipeable.actions.isEmpty
		}
		return true
	}

	open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return (self.item(for: indexPath) as? EditableTableViewItem)?.editingStyle ?? .none
	}

	open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if let item = self.item(for: indexPath) as? EditableTableViewItem, item.editingStyle == editingStyle {
			item.editingAction()
		}
	}

    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let item = item(for: indexPath) as? SwipeableTableViewItem else { return nil }
        guard !item.actions.isEmpty else { return nil }
        return item.actions
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

extension Adaptable where Self: BaseTableViewAdapter {
    public func tableViewSection(for index: Int) -> BaseTableViewSection? {
        return section(for: index) as? BaseTableViewSection
    }

    public func item(for indexPath: IndexPath) -> TableViewItem? {
        guard indexPath.hasSectionAndItem else { return nil }
        return section(for: indexPath.section)?
            .item(for: indexPath.row) as? TableViewItem
    }
}

#endif
