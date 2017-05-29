//
//  BodyFile.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

public extension Body {
    
    public struct File: BodyItemRepresentable {
        
        public static let defaultName = "file"
        
        public static let defaultMimeType = "application/octet-stream"
        
        public var name: String
        
        public var filename: String?
        
        public var mimeType: String
        
        public var data: Data
        
        public init(name: String = File.defaultName,
                    filename: String? = nil,
                    mimeType: String = File.defaultMimeType,
                    data: Data) {
            self.name = name
            self.filename =  filename
            self.mimeType = mimeType
            self.data = data
        }
        
        public var bodyItems: [BodyItemRepresentable] {
            let contentDisposition = HeaderField.init(.contentDisposition,
                                                      value: .contentDisposition(.formData),
                                                      attributes: .contentDisposition(.name(name, filename: filename)))
            
            let contentType = HeaderField.init(.contentType, value: .with(mimeType))
            
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
