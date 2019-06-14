//
//  BaseCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

open class BaseCollectionViewAdapter: NSObject, Adaptable, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    open var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }

    open func reloadData() {
        collectionView?.reloadData()
    }

    // MARK: Adaptable

    open var sectionCount: Int {
        fatalError("Must override")
    }

    open func section(for index: Int) -> Section? {
        fatalError("Must override")
    }

    // MARK: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section(for: section)?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.item(for: indexPath)!
        let cell = item.dequeueCell(from: collectionView, at: indexPath)

        item.configure(cell: cell)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return self.item(for: indexPath)?.didSelectItem != nil
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didSelectItem?()
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.item(for: indexPath)?.didDeselectItem?()
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.item(for: indexPath)?.size(collectionView)
            ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize
            ?? CGSize.zero
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = self.collectionViewSection(for: indexPath.section) else { return UICollectionReusableView() }
        guard let supplementary = section.dequeueSupplementaryView(for: collectionView, kind: kind, indexPath: indexPath) else { return UICollectionReusableView() }

        if kind == UICollectionView.elementKindSectionHeader {
            section.configure(header: supplementary)
        }

        if kind == UICollectionView.elementKindSectionFooter {
            section.configure(footer: supplementary)
        }

        return supplementary
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.collectionViewSection(for: section)?.sizeForHeader(collectionView)
            ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize
            ?? CGSize.zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.collectionViewSection(for: section)?.sizeForFooter(collectionView)
            ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize
            ?? CGSize.zero
    }

    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return self.item(for: indexPath) is ActionPerformableCollectionViewItem
    }

    public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return (self.item(for: indexPath) as? ActionPerformableCollectionViewItem)?.canPerform(action: action, withSender: sender) ?? false
    }

    public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        (self.item(for: indexPath) as? ActionPerformableCollectionViewItem)?.perform(action: action, withSender: sender)
    }
}

fileprivate extension Adaptable where Self: BaseCollectionViewAdapter {
    func collectionViewSection(for index: Int) -> CollectionViewSection? {
        return section(for: index) as? CollectionViewSection
    }

    func item(for indexPath: IndexPath) -> CollectionViewItem? {
        return section(for: indexPath.section)?
            .item(for: indexPath.row) as? CollectionViewItem
    }
}
