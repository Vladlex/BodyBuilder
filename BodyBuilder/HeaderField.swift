//
//  HeaderField.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

public struct HeaderField: BodyItemRepresentable, CustomStringConvertible {
    
    public var name: Name
    
    public var value: Value
    
    public var attributes: [Attribute]
    
    public var entry: String {
        let base = "\(name.rawValue): \(value.rawValue)"
        let attributeEntries = attributes.map({ $0.entry })
        var entries: [String] = [base]
        entries.append(contentsOf: attributeEntries)
        return entries.joined(separator: "; ")
    }
    
    public init(name: Name, value: Value, attributes: [Attribute] = []) {
        self.name = name
        self.value = value
        self.attributes = attributes
        
    }
    
    public init(name: Name, value: Value, attrs: DictionaryLiteral<String, String>) {
        let attributes = attrs.map({ Attribute.init(key: $0.key, value: $0.value)})
        self.init(name: name, value: value, attributes: attributes)
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
}


extension HeaderField {
    
    public static func createMultipartFormFile(name: String, filename: String?) -> HeaderField {
        var attributes: [Attribute] = [Attribute.init(key: "name", value: name)]
        if let filename = filename {
            attributes.append(Attribute.init(key: "filename", value: filename))
        }
        return self.init(name: .contentDisposition, value: .formData, attributes: attributes)
    }
    
    public static func createMultipartFormDispositionItem(named: String) -> HeaderField {
        return self.init(name: .contentDisposition, value: .formData, attributes: [
            .init(key: "name", value: "\"\(named)\"")
            ])
    }
    
}
