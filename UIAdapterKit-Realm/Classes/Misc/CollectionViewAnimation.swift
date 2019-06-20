//
//  CollectionViewAnimation.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 10/06/2019.
//

public enum CollectionViewAnimation: Equatable {
    case none
    case section
    case row
    
    public static func ==(lhs: CollectionViewAnimation, rhs: CollectionViewAnimation) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.section, .section):
            return true
        case (.row, .row):
            return true
        default:
            return false
        }
    }
}
