//
//  BodyBuilderTests.swift
//  BodyBuilderTests
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import XCTest
@testable import BodyBuilder

class BodyBuilderTests: XCTestCase {
    
    func testMultipleCreationWays() {
        // MARK: Given & When
        let authHeader1 = HeaderField.init(name: "Authorization", value: .with("Basic 123456789=="))
        let authHeader2 = HeaderField.init(.authorization, value: .with("Basic 123456789=="))
        let authHeader3 = HeaderField.init(.authorization, value: .authorization(.basic("123456789==")))
        
        
        
        let expected = "Authorization: Basic 123456789=="
        
        // MARK: Then
        XCTAssertEqual(authHeader1, authHeader2)
        XCTAssertEqual(authHeader2, authHeader1)
        
        XCTAssertEqual(authHeader2, authHeader3)
        XCTAssertEqual(authHeader3, authHeader2)
        
        XCTAssertEqual(authHeader3, authHeader1)
        XCTAssertEqual(authHeader1, authHeader3)
        
        for header in [authHeader1, authHeader2, authHeader3] {
            let string = String.init(data: header.httpRequestBodyData, encoding: .utf8)!
            XCTAssertEqual(string, expected)
        }
    }
    
    func testContentDisposition() {
        // Given & When
        let name = "\"ITEM_NAME\""
        let filename = "\"ITEM_FILENAME\""
        
        let header1 = HeaderField.init(name: "Content-Disposition",
                                       value: .with("form-data"),
                                       attributes: [.init(key: "name", value: name),
                                                    .init(key: "filename", value: filename)])
        let header2 = HeaderField.init(.contentDisposition,
                                       value: .contentDisposition(.formData),
                                       attributes: .contentDisposition([.name(name), .filename(filename)]))
        let header3 = HeaderField.init(.contentDisposition,
                                       value: .contentDisposition(.formData),
                                       attributes: .contentDisposition(.name(name, filename: filename)))
        
        let expected = "Content-Disposition: form-data; name=\"ITEM_NAME\"; filename=\"ITEM_FILENAME\""
        
        for header in [header1, header2, header3] {
            let string = String.init(data: header.httpRequestBodyData, encoding: .utf8)
            XCTAssertEqual(string, expected)
        }
        
    }
    
}
