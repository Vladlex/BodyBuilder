//
//  Data+BodyBuilder.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 08/06/2017.
//

import Foundation

extension Data {
    
    private typealias DataRange = Range<Index>
    
    public func componentRanges(separatedBy separator: Data) -> [Range<Data.Index>] {
        guard self.count > 0 else {
            return []
        }
        
        let wholeRange: DataRange = 0..<self.count
        var searchRange = wholeRange
        
        var foundItemRangeStart : Index = 0
        var foundRange: DataRange? = range(of: separator, options: .init(rawValue: 0) , in: searchRange)
        
        var ranges: [DataRange] = []
        
        while let range = foundRange {
            guard range.count > 0 else {
                break
            }
            
            let separatorStartIndex = range.lowerBound
            
            guard separatorStartIndex > foundItemRangeStart else {
                break
            }
            
            let itemRange = DataRange.init(uncheckedBounds: (lower: foundItemRangeStart, upper: separatorStartIndex))
            ranges.append(itemRange)
            
            if itemRange.upperBound < wholeRange.upperBound {
                foundItemRangeStart = range.upperBound
                foundRange = self.range(of: separator, options: .init(rawValue: 0), in: searchRange)
            }
        }
        
        if foundItemRangeStart < wholeRange.upperBound {
            let lastRange = DataRange.init(uncheckedBounds: (lower: foundItemRangeStart, upper: wholeRange.upperBound))
            ranges.append(lastRange)
        }
        
        return ranges
    }
}
