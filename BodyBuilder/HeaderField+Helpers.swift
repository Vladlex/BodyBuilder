//
//  HeaderField+Helpers.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 15/01/2018.
//

import Foundation

public extension HeaderField {
    public static func multipartFormData(boundary: Boundary) -> HeaderField {
        return self.init(.contentType, value: .multipartFormData(boundary: boundary))
    }
}
