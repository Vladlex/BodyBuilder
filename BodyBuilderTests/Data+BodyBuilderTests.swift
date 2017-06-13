//
//  Data+BodyBuilderTests.swift
//  BodyBuilderTests
//
//  Created by Aleksei Gordeev on 08/06/2017.
//

import XCTest

class Data_BodyBuilderTests: XCTestCase {
    
    func testDataWithoutSeparator() {
        let string = "Testing data without separator"
        let data = string.data(using: .utf8)!
        let ranges = data.componentRanges(separatedBy: "no_sep".data(using: .utf8)!)
        
        XCTAssertEqual(ranges.count, 1)
        
        let executedData = data.subdata(in: ranges.first!)
        XCTAssertEqual(string, String.init(data: executedData, encoding: .utf8))
        XCTAssertEqual(executedData, data)
    }
    
    func testSimpleDataSeparation() {
        let dataSeparator = "Separator".data(using: .utf8)!
        var data = Data()
        for i in 0..<10 {
            if i > 0 {
                data.append(dataSeparator)
            }
            data.append("ITEM_\(i)".data(using: .utf8)!)
        }
        
        let chunkRanges = data.componentRanges(separatedBy: dataSeparator)
        chunkRanges.enumerated().forEach { (arg) in
            let (idx, range) = arg
            let chunk = data.subdata(in: range)
            let string = String.init(data: chunk, encoding: .utf8)
            XCTAssertEqual(string, "ITEM_\(idx)")
        }
    }
    
    func testSeparatorsOnlyData() {
        let dataSeparator = "Separator".data(using: .utf8)!
        let separators = Array<Data>.init(repeating: dataSeparator, count: 5)
        let data = separators.reduce(Data()) { (data, separator) -> Data in
            var data = data
            data.append(separator)
            return data
        }
        let ranges = data.componentRanges(separatedBy: dataSeparator)
        
    }
    
}
