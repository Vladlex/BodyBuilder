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
        var ranges: [DataRange] = []
        
        var searchEnded = true
        repeat {
            let currentRangeUpperBound: Int
            
            let originalSearchRange = searchRange
            if let separatorRange = range(of: separator, options: .init(rawValue: 0) , in: searchRange) {
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
