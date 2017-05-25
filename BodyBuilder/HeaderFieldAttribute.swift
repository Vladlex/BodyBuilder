//
//  HeaderFieldAttribute.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

extension HeaderField {
    
    public struct Attribute: CustomStringConvertible {
        
        public var key: String
        
        public var value: String
        
        public var entry: String {
            return "\(key)=\(value)"
        }
        
        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
        
        public init(_ key: String, _ value: String) {
            self.init(key: key, value: value)
        }
        
        public var description: String {
            return self.entry
        }
    }
    
}
