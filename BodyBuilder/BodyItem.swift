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

extension Data: BodyItemRepresentable {
    
    public var httpRequestBodyData: Data {
        return self
    }
    
    public var httpRequestBodyDescription: String {
        return "<Some Data>"
    }
    
}
