//
//  HeaderFieldAttribute+Basic.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 31/05/2017.
//
//

import XCTest
@testable import BodyBuilder

class HeaderFieldAttribute_Basic: XCTestCase {

    func testBasicInitialization() {
        // Given & When
        let key = "key_123"
        let value = "value_098"
        let attribute1 = HeaderField.Attribute.init(key: key, value: value)
        let attribute2 = HeaderField.Attribute(key: key, value: value)
        
        // Then
        XCTAssertEqual(key, attribute1.key)
        XCTAssertEqual(value, attribute1.value)
        
        XCTAssertEqual(attribute1.key, attribute2.key)
        XCTAssertEqual(attribute1.value, attribute2.value)
        
        XCTAssertEqual(attribute2.key, "key_123")
        XCTAssertEqual(attribute2.value, "value_098")
    }
    
    func testEntry() {
        // Given & When
        let key = "key_555"
        let value = "val_678"
        let attribute = HeaderField.Attribute.init(key: key, value: value)
        
        XCTAssertEqual(attribute.entry, "key_555=val_678")
    }

}
