//
//  Item.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

public enum RegistrationType {
    case nib(_ nib: UINib)
    case clazz(_ clazz: UIView.Type)
}

public typealias SelectionCompletion = () -> Void

public protocol Item: Identifiable {
    var reuseIdentifier: String { get }
    var registrationType: RegistrationType { get }
    
    var didSelectItem: SelectionCompletion? { get }
    var didDeselectItem: SelectionCompletion? { get }
}

public extension Item {
    var reuseIdentifier: String { return identifier(self) }
    
    var registrationType: RegistrationType {
        return .nib(UINib(nibName: reuseIdentifier, bundle: nil))
    }
    
    var didSelectItem: SelectionCompletion? { return nil }
    
    var didDeselectItem: SelectionCompletion? { return nil }
}
