//
//  IndexPath+Validate.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 25/03/2020.
//

import Foundation

extension IndexPath {
    var hasSectionAndItem: Bool {
        return count == 2
    }
}
