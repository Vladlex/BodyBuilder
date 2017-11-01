//
//  Data+BodyBuilder.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 08/06/2017.
//

import Foundation

extension Data {
    
    private typealias DataRange = Range<Index>
    
    /**
     Returns an array of ranges the data that have been divided by a given separator.
     
     - parameters:
         - separator: The separator to break data into chunks
         - inRange: Search bounds. If nil then searching whole string. The efault is nil.
     
     Respects separators in a row. For an example:
     if data consist of two sepators and nothing else – the result will contain three ranges with 0 lengths:
     */
    public func componentRanges(separatedBy separator: Data, in range: Range<Index>? = nil) -> [Range<Data.Index>] {
        guard self.count > 0 else {
            return []
        }
        
        let wholeRange: DataRange = range ?? 0..<self.count
        var searchRange = wholeRange
        var ranges: [DataRange] = []
        
        var searchEnded = false
        repeat {
            let currentRangeUpperBound: Int
            
            let originalSearchRange = searchRange
            if let separatorRange = self.range(of: separator, options: .init(rawValue: 0) , in: searchRange) {
                currentRangeUpperBound = separatorRange.lowerBound
                searchRange = separatorRange.upperBound..<wholeRange.upperBound
            }
            else {
                currentRangeUpperBound = wholeRange.upperBound
            }
            
            let currentRange: DataRange = originalSearchRange.lowerBound..<currentRangeUpperBound
            ranges.append(currentRange)
            
            if currentRangeUpperBound == wholeRange.upperBound {
                searchEnded = true
            }
            
        } while !searchEnded
        
        return ranges
    }
}
