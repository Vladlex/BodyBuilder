//
//  HeaderFieldName.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

extension HeaderField {
    
    public struct Name : RawRepresentable, Equatable, Hashable, Comparable {
        
        public private(set) var rawValue: String
        
        public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        /// :nodoc:
        public static func ==(lhs: Name, rhs: Name) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        /// :nodoc:
        public static func <(lhs: Name, rhs: Name) -> Bool {
            return rhs.rawValue < rhs.rawValue
        }
        
        /// :nodoc:
        public var hashValue: Int {
            return self.rawValue.hashValue
        }
        
    }

    
}


extension HeaderField.Name {
    
    /// Content-Disposition
    public static let contentDisposition = HeaderField.Name.init("Content-Disposition")
    
    /// Content-Type
    public static let contentType = HeaderField.Name.init("Content-Type")
}
