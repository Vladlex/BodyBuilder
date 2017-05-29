//
//  HeaderField.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation


public struct HeaderField: BodyItemRepresentable, CustomStringConvertible, Hashable {
    
    public var name: HeaderField.Name
    
    public var value: HeaderField.Value
    
    public var attributes: [Attribute]
    
    public var entry: String {
        let base = "\(name.rawValue): \(value.string)"
        let attributeEntries = attributes.map({ $0.entry })
        var entries: [String] = [base]
        entries.append(contentsOf: attributeEntries)
        return entries.joined(separator: "; ")
    }
    
    public init(name: String, value: Value, attributes: [Attribute] = []) {
        self.init(.init(name), value: value, attributes: attributes)
    }
    
    public init(_ name: Name, value: Value, attributes: [Attribute] = []) {
        self.name = name
        self.value = value
        self.attributes = attributes
    }
    
    public var description: String {
        return self.entry
    }
    
    public var httpRequestBodyData: Data {
        return self.entry.data(using: .utf8)!
    }
    
    public var httpRequestBodyDescription: String {
        return self.entry
    }
    
    public var hashValue: Int {
        return self.name.hashValue ^ self.value.hashValue
    }
    
    public static func ==(lhs: HeaderField, rhs: HeaderField) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }
}
