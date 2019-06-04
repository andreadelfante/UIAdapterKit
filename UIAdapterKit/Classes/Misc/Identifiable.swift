//
//  Identifiable.swift
//  UIAdapterKit
//
//  Created by Andrea Del Fante on 04/06/2019.
//

public protocol Identifiable {
    
}

extension Identifiable {
    func identifier(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
