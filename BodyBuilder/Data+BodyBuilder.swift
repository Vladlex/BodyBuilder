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
        
        
        var lastFoundDataRangeUpperBound: Int = 0
        
        var searchEnded = true
        repeat {
            guard let separatorRange = range(of: separator, options: .init(rawValue: 0) , in: searchRange) else {
                let lastRange: DataRange = lastFoundDataRangeUpperBound..<wholeRange.upperBound
                ranges.append(lastRange)
                searchEnded = true
                break
            }
            
            
            
            if separatorRange.upperBound < wholeRange.upperBound {
                
            }
            
        } while !searchEnded
        
        return ranges
    }
}
