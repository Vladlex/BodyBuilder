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
    
    public static func uuidBased(mutator: Mutator = []) -> Boundary {
        return self.init(value: UUID().uuidString, mutator: mutator)
    }
    
    public let value: String
    
    public let mutator: Mutator
    
    public var isPrefixed: Bool {
        return self.mutator.contains(.prefixed)
    }
    
    public var isSuffixed: Bool {
        return self.mutator.contains(.suffixed)
    }
    
    public var wrappedValue: String {
        var string = String.init()
        if isPrefixed {
            string.append("--")
        }
        string.append(value)
        if isSuffixed {
            string.append("--")
        }
        return string
    }
    
    public init(value: String, mutator: Mutator = []) {
        self.value = value
        self.mutator = mutator
    }
    
    public var httpRequestBodyData: Data {
        return wrappedValue.data(using: .utf8)!
    }
    
    public var httpRequestBodyDescription: String {
        return "Boundary<\(self.wrappedValue)>"
    }
    
    public func mutating(_ mutator: Mutator) -> Boundary {
        return Boundary.init(value: self.value, mutator: mutator)
    }
    
    public struct Mutator: OptionSet {
        
        public typealias RawValue = Int
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let prefixed = Mutator.init(rawValue: 1 << 0)
        public static let suffixed = Mutator.init(rawValue: 1 << 1)
        
        public static let wrapped: Mutator = [.prefixed, .suffixed]
        
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
