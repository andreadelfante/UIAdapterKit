//
//  ArraySearchableCollectionViewAdapter.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 31/03/2020.
//

#if canImport(UIKit)

import Foundation
import UIKit

open class ArraySearchableCollectionViewAdapter: ArrayCollectionViewAdapter {
    public private(set) var isSeeking: Bool
    public private(set) var filteredItemsCount: Int
    public private(set) var filterPayload: Any?
    private var filteredSections: [BaseCollectionViewSection]

    public override init() {
        isSeeking = false
        filteredItemsCount = 0
        filteredSections = []

        super.init()
    }

    public override var hasItems: Bool {
        return isSeeking ? filteredItemsCount > 0 : super.hasItems
    }

    open override var sectionCount: Int {
        return isSeeking ? filteredSections.count : super.sectionCount
    }

    open override func section(for index: Int) -> Section? {
        guard isSeeking else { return super.section(for: index) }
        guard 0 <= index && index < sectionCount else { return nil }
        return filteredSections[index]
    }

    open override func append<T>(section: ArrayCollectionViewSection<T>) {
        super.append(section: section)

        if isSeeking {
            filter(with: filterPayload)
        }
    }

    @discardableResult
    open override func insert<T>(section: ArrayCollectionViewSection<T>, at index: Int) -> Bool {
        let result = super.insert(section: section, at: index)

        if isSeeking {
            filter(with: filterPayload)
        }

        return result
    }

    @discardableResult
    open override func replace<T>(section: ArrayCollectionViewSection<T>, at index: Int) -> Bool {
        let result = super.replace(section: section, at: index)

        if isSeeking {
            filter(with: filterPayload)
        }

        return result
    }

    @discardableResult
    open override func remove(at index: Int) -> Bool {
        let result = super.remove(at: index)

        if isSeeking {
            filter(with: filterPayload)
        }

        return result
    }

    open override func removeAll() {
        super.removeAll()

        if isSeeking {
            filter(with: filterPayload)
        }
    }

    public func filter(
        with payload: Any?,
        completionQueue: DispatchQueue = DispatchQueue.main,
        completion: (() -> Void)? = nil
    ) {
        filteredItemsCount = 0
        isSeeking = false
        filteredSections = []
        filterPayload = payload

        if payload != nil {
            isSeeking = true

            DispatchQueue(label: "\(String(describing: self)).FilterQueue").async { [weak self] in
                guard let self = self else { return }
                let payload = payload!

                for var section in self.sections {
                    if let filterableSection = section.copy() as? (BaseCollectionViewSection & PerformableFilter) {
                        filterableSection.performFilter(with: payload)
                        section = filterableSection
                    }

                    self.filteredItemsCount += section.count
                    self.filteredSections.append(section)
                }

                DispatchQueue.main.async { [weak self] in
                    self?.reloadData()
                }

                if let completion = completion {
                    completionQueue.async(execute: completion)
                }
            }
        } else {
            reloadData()
        }
    }
}

#endif
