//
//  BodyFile.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

extension Body {
    
    public struct File: BodyItemRepresentable {
        
        public static let defaultName = "file"
        
        public static let defaultMimeType = "application/octet-stream"
        
        public var name: String
        
        public var filename: String?
        
        public var mimeType: String
        
        public var data: Data
        
        public init(name: String = File.defaultName,
                    quoteName: Bool = true,
                    filename: String? = nil,
                    quoteFilename: Bool = true,
                    mimeType: String = File.defaultMimeType,
                    data: Data) {
            self.name = quoteName ? name.wrappingByQuotes() : name
            self.filename =  quoteFilename ? filename?.wrappingByQuotes() : filename
            self.mimeType = mimeType
            self.data = data
        }
        
        public var bodyItems: [BodyItemRepresentable] {
            let contentDisposition = HeaderField.createMultipartFormFile(name: self.name,
                                                                         filename: self.filename)
            let contentType = HeaderField.init(name: HeaderField.Name.contentType,
                                               value: HeaderField.Value.init(rawValue: self.mimeType))
            
            let items: [BodyItemRepresentable] = [
                contentDisposition, String.httpRequestBodyLineBreak,
                contentType, String.httpRequestBodyLineBreak,
                String.httpRequestBodyLineBreak,
                self.data
            ]
            return items
        }
        
        public var httpRequestBodyData: Data {
            var data: Data = Data.init()
            self.bodyItems.forEach({data.append($0.httpRequestBodyData)})
            return data
        }
        
        public var httpRequestBodyDescription: String {
            let descriptions: [String] = self.bodyItems.map({ $0.httpRequestBodyDescription})
            return descriptions.joined()
        }
        
    }
    
}
