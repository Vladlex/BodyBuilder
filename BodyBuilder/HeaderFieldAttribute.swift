//
//  HeaderFieldAttribute.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation

public extension HeaderField {
    
    public struct Attribute: CustomStringConvertible {
        
        public let key: String
        
        public let value: String
        
        public var entry: String {
            return "\(key)=\(value)"
        }
        
        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
        
        public init(_ key: String, _ value: String) {
            self.init(key: key, value: value)
        }
        
        public var description: String {
            return self.entry
        }
    }
    
}

extension HeaderField.Attribute {
    
    public enum ContentDisposition {
        case filename(String)
        case creationDate(String)
        case modificationDate(String)
        case readDate(String)
        case size(String)
        case name(String)
        case voice(Voice)
        case handling(required: Bool)
        case previewType(String)
        
        public var attribute: HeaderField.Attribute {
            switch self {
            case let .filename(filename): return HeaderField.Attribute(key: "filename", value: filename)
            case let .creationDate(date): return HeaderField.Attribute(key: "creation-date", value: date)
            case let .modificationDate(date): return HeaderField.Attribute(key: "modification-date", value: date)
            case let .readDate(date): return HeaderField.Attribute(key: "read-date", value: date)
            case let .size(size): return HeaderField.Attribute(key: "size", value: size)
            case let .name(name): return HeaderField.Attribute(key: "name", value: name)
            case let .previewType(previewType): return HeaderField.Attribute(key: "preview-type", value: previewType)
            case let .voice(voice): return HeaderField.Attribute(key: "voice", value: voice.rawValue)
            case let .handling(required): return HeaderField.Attribute(key: "handling",
                                                                       value: required ? "required" : "optional")
            }
        }
        
        public enum Voice: String {
            case voiceMessage = "Voice-Message"
            case voiceMessageNotification = "Voice-Message-Notification"
            case originatorSpokenName = "Originator-Spoken-Name"
            case recipientSpokenName = "Recipient-Spoken-Name"
            case spokenSubject = "Spoken-Subject"
        }
    }
}

public extension Array where Element == HeaderField.Attribute.ContentDisposition {
    public static func name(_ name: String, filename: String? = nil) -> [HeaderField.Attribute.ContentDisposition] {
        var items = [HeaderField.Attribute.ContentDisposition.name(name)]
        if let filename = filename {
            items.append(.filename(filename))
        }
        return items
    }
}

extension Array where Element == HeaderField.Attribute {
    
    static func contentDisposition(_ values:[HeaderField.Attribute.ContentDisposition]) -> [HeaderField.Attribute] {
        return values.map({$0.attribute})
    }
    
    static func contentDisposition(name: String, filename: String? = nil) -> [HeaderField.Attribute] {
        var items = [HeaderField.Attribute.ContentDisposition.name(name)]
        if let filename = filename {
            items.append(.filename(filename))
        }
        return contentDisposition(items)
    }
    
}
