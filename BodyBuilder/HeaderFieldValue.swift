//
//  HeaderFieldValue.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

extension HeaderField {
    
    public struct Value: RawRepresentable, Equatable, Hashable, Comparable {
        
        public private(set) var rawValue: String
        
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static func ==(lhs: Value, rhs: Value) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        public static func <(lhs: Value, rhs: Value) -> Bool {
            return rhs.rawValue < rhs.rawValue
        }
        
        public var hashValue: Int {
            return self.rawValue.hashValue
        }
        
    }

}


public extension HeaderField.Value {
    
    public static let formData = HeaderField.Value.init("form-data")
    
}
