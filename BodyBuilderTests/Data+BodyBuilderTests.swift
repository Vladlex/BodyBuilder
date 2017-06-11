//
//  Data+BodyBuilderTests.swift
//  BodyBuilderTests
//
//  Created by Aleksei Gordeev on 08/06/2017.
//

import XCTest

class Data_BodyBuilderTests: XCTestCase {
    
    func testSimpleDataSeparation() {
        let dataSeparator = "Separator".data(using: .utf8)!
        var data: Data = Data()
        for i in 0..<10 {
            if i > 0 {
                data.append(dataSeparator)
            }
            data.append("ITEM_\(i)".data(using: .utf8)!)
        }
        
        let chunkRanges = data.componentRanges(separatedBy: dataSeparator)
        chunkRanges.enumerated().forEach { (arg) in
            let (idx, range) = arg
            let chunk = data[range]
            let string = String.init(data: chunk, encoding: .utf8)
            XCTAssertEqual(string, "ITEM_\(idx)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
