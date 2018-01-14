//
//  URLRequest+BodyBuilder.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 15/01/2018.
//

import Foundation

public extension URLRequest {
    mutating func setValue(_ value: String?, forHTTPHeaderFieldNamed name: HeaderField.Name) {
        self.setValue(value, forHTTPHeaderField: name.rawValue)
    }
}
