//
//  BodyItem.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

public protocol BodyItemRepresentable {
    var httpRequestBodyData: Data { get }
    var httpRequestBodyDescription: String { get }
}

extension String: BodyItemRepresentable {
    
    public var httpRequestBodyData: Data {
        return self.data(using: .utf8)!
    }
    
    public var httpRequestBodyDescription: String {
        return self
    }
    
    public static let httpRequestBodyLineBreak = "\r\n"
}

public extension String {
    
    public func wrappingByQuotes() -> String {
        return self.wrapping(by: "\"")
    }
    
    public func wrapping(by string: String) -> String {
        return self.wrapping(byPrefix: string, suffix: string)
    }
    
    public func wrapping(byPrefix prefix: String, suffix: String) -> String {
        return "\(prefix)\(self)\(suffix)"
    }
    
    mutating public func wrap(by string: String) {
        self = self.wrapping(by: string)
    }
    
    mutating public func wrap(byPrefix prefix: String, suffix: String) {
        self = self.wrapping(byPrefix: prefix, suffix: suffix)
    }
}

public struct Boundary: BodyItemRepresentable {
    
    public var value: String
    
    public var prefixed: Bool
    
    public var suffixed: Bool
    
    public var wrappedValue: String {
        var string = String.init()
        if prefixed {
            string.append("--")
        }
        string.append(value)
        if suffixed {
            string.append("--")
        }
        return string
    }
    
    public init(value: String, prefixed: Bool = false, suffixed: Bool = false) {
        self.value = value
        self.suffixed = suffixed
        self.prefixed = prefixed
    }
    
    public var httpRequestBodyData: Data {
        return wrappedValue.data(using: .utf8)!
    }
    
    public var httpRequestBodyDescription: String {
        return "Boundary<\(self.wrappedValue)>"
    }
    
}

extension Data: BodyItemRepresentable {
    
    private static let bytesFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter.init()
        return formatter
    }()
    
    public var httpRequestBodyData: Data {
        return self
    }
    
    public var httpRequestBodyDescription: String {
        let bytesLengthString = Data.bytesFormatter.string(fromByteCount: Int64(self.count))
        return "<Bytes (length: \(bytesLengthString))>"
    }
    
}
