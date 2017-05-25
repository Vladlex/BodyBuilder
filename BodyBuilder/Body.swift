//
//  Body.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

public struct Body: CustomStringConvertible {
    
    var items: [BodyItemRepresentable] = []
    
    var data: Data {
        var data = Data.init()
        items.forEach({ data.append($0.httpRequestBodyData) })
        return data
    }
    
    /**
     * String representaiton of the body.
     * If you want line-by-line representation in Xcode consle print "po print(body)"
     */
    public var description: String {
        let itemDescriptions = self.items.map({$0.httpRequestBodyDescription})
        return itemDescriptions.joined()
    }
    
}

extension Body {
    
    mutating public func append(byLineBreaks: Int) {
        guard byLineBreaks > 0 else {
            return
        }
        let string = String.init(repeating: "\r\n", count: byLineBreaks)
        self.items.append(string)
    }
    
    mutating public func append(byHeaderField: HeaderField, lineBreaks: Int = 1) {
        self.items.append(byHeaderField)
        self.append(byLineBreaks: lineBreaks)
    }
    
    mutating public func append(byString: String, lineBreaks: Int = 1) {
        self.append(by: byString)
        self.append(byLineBreaks: lineBreaks)
    }
    
    mutating public func append(byItems: [BodyItemRepresentable], lineBreaks: Int = 1) {
        self.items.append(contentsOf: byItems)
        self.append(byLineBreaks: lineBreaks)
    }
    
    mutating public func append(by items: BodyItemRepresentable...) {
        self.append(byItems: items, lineBreaks: 0)
    }
    
    mutating public func append(byBoundary: String, prefixed: Bool = true, suffixed: Bool = false, lineBreaks: Int = 1) {
        var string = String.init()
        if prefixed {
            string.append("--")
        }
        string.append(byBoundary)
        if suffixed {
            string.append("--")
        }
        self.append(byString: string, lineBreaks: lineBreaks)
    }
    
}
