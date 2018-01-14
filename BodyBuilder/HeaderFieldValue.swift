//
//  HeaderFieldValue.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation


public protocol HeaderValueRepresentable {
    var headerValueString: String { get }
}

public extension HeaderValueRepresentable {
    var headerValue: HeaderField.Value {
        return HeaderField.Value.init(self.headerValueString)
    }
}

extension String: HeaderValueRepresentable {
    public var headerValueString: String {
        return self
    }
}


public extension HeaderField {
    
    public struct Value: RawRepresentable, Equatable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
        
        public typealias RawValue = HeaderValueRepresentable
        
        public private(set) var rawValue: RawValue
        
        public var string: String {
            return self.rawValue.headerValueString
        }
        
        /// Shortcut for creating with string
        public static func with(_ string: String) -> Value {
            return self.init(string)
        }
        
        public init(_ rawValue: RawValue) {
            self.init(rawValue: rawValue)
        }
        
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValues: String...) {
            self.init(rawValues: rawValues)
        }
        
        public init(rawValues: [String]) {
            self.init(rawValues.joined(separator: ", "))
        }
        
        public static func ==(lhs: Value, rhs: Value) -> Bool {
            return lhs.string == rhs.string
        }
        
        public static func <(lhs: Value, rhs: Value) -> Bool {
            return rhs.string < rhs.string
        }
        
        public var hashValue: Int {
            return self.string.hashValue
        }
        
        public var description: String {
            return self.string
        }
        
        public var debugDescription: String {
            return String(describing: self.rawValue)
        }
    }
    
}

// TODO: Move to separate file if apple fixes https://bugs.swift.org/browse/SR-4389

// MARK: - Predefined Values

public extension HeaderField.Value {
    
    // MARK: Multipart Form Data Content Type
    
    public static func multipartFormData(boundary: Boundary) -> HeaderField.Value {
        return HeaderField.Value.init("multipart/form-data; boundary=\(boundary.value)")
    }
    
    // MARK: Authorization
    
    public static func authorization(_ value: Authorization) -> HeaderField.Value {
        return HeaderField.Value.init(value)
    }
    
    public enum Authorization: HeaderValueRepresentable {
        
        public var headerValueString: String {
            switch self {
            case let .basic(encodedUserAndPassword): return "Basic \(encodedUserAndPassword)"
            }
        }
        
        case basic(String)
        
    }
    
    
    // MARK: Allow
    
    public static func allow(_ value: Allow) -> HeaderField.Value {
        return HeaderField.Value.init(value)
    }
    
    public struct Allow: OptionSet, HeaderValueRepresentable {
        
        public typealias RawValue = Int
        
        public let rawValue: RawValue
        
        public init(_ rawValue: RawValue) {
            self.init(rawValue: rawValue)
        }
        
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
        
        public var headerValueString: String {
            var strings: [String] = []
            if self.contains(.options) {
                strings.append("OPTIONS")
            }
            if self.contains(.get) {
                strings.append("GET")
            }
            if self.contains(.head) {
                strings.append("HEAD")
            }
            
            return strings.joined(separator: ", ")
        }
        
        static let options =    Allow.init(1 << 0)
        static let get =        Allow.init(1 << 1)
        static let head =       Allow.init(1 << 2)
        
    }
    
    
    // MARK: Cache-Control
    
    public static func cacheControl(_ value: CacheControl) -> HeaderField.Value {
        return HeaderField.Value.init(value)
    }
    
    public struct CacheControl: HeaderValueRepresentable {
        
        public var headerValueString: String {
            return rules.map({$0.string}).joined(separator: ", ")
        }
        
        public var rules: [Rule]
        
        public static func rules(_ rules: Rule...) -> CacheControl {
            return self.init(rules: rules)
        }
        
        public init(rules: [Rule]) {
            self.rules = rules
        }
        
        /**
         Rules describing willing cache control.
         
         Most of descriptions are from https://developer.mozilla.org/ru/docs/Web/HTTP/Headers/Cache-Control
         */
        public enum Rule {
            
            /// For how long content should be treates as fresh, relatively since receiving request.
            case maxAge(seconds: Int)
            
            /**
             Indicates that the client is willing to accept a response that has exceeded its expiration time.
             
             Optionally, you can assign a value in seconds, indicating the time the response must not be expired by.
             */
            case maxStale(seconds: Int?)
            
            /// Indicates that the client wants a response that will still be fresh for at least the specified number of seconds.
            case minFresh(seconds: Int)
            
            /**
             Forces caches to submit the request to the origin server for validation before releasing a cached copy.
             */
            case noCache
            
            /// The cache should not store anything about the client request or server response.
            case noStore
            
            
            /// Indicates to not retrieve new data.
            case onlyIfCached
            
            /**
             No transformations or conversions should made to the resource.
             
             The Content-Encoding, Content-Range, Content-Type headers must not be modified by a proxy.
             */
            case noTransform
            
            /// For general (proxy) cahce. Proxy cache MUST first revalidate it with the origin.
            case sMaxAge(seconds: Int)
            
            /// Indicates that the response MAY be cached by any cache, even if it would normally be non-cacheable or cacheable only within a non-shared cache
            case `public`
            
            /// Indicates that all or part of the response message is intended for a single user and MUST NOT be cached by a shared cache.
            case `private`
            
            /// The cache must verify the status of the stale resources before using it and expired ones should not be used.
            case mustRevalidate
            
            /// Same as must-revalidate, but it only applies to shared caches (e.g., proxies) and is ignored by a private cache.
            case proxyRevalidate
            
            /**
             Indicates that the response body will not change over time. **Experimental**
             */
            case immutable
            
            public var string: String {
                switch self {
                case let .maxAge(seconds: seconds): return "max-age=\(seconds)"
                case let .sMaxAge(seconds: seconds): return "s-maxage=\(seconds)"
                case .mustRevalidate: return "must-revalidate"
                case .noCache: return "no-cache"
                case .noStore: return "no-store"
                case .private: return "private"
                case .proxyRevalidate: return "proxy-revalidate"
                case .public: return "pubic"
                case .onlyIfCached: return "only-if-cached"
                case .immutable: return "immutable"
                case let .maxStale(seconds: seconds): return seconds != nil ? "max-stale" : "max-stale=\(seconds!)"
                case let .minFresh(seconds: seconds): return "min-fresh=\(seconds)"
                case .noTransform: return "no-transform"
                }
            }
        }
        
    }
    
    public static func contentDisposition(_ value: ContentDisposition) -> HeaderField.Value {
        return HeaderField.Value.init(value)
    }
    
    
    public enum ContentDisposition: String, HeaderValueRepresentable, RawRepresentable {
        
        case inline = "inline"
        
        case formData = "form-data"
        
        case attachment = "attachment"
        
        case signal = "signal"
        
        case alert = "alert"
        
        case icon = "icon"
        
        case render = "render"
        
        case recipientListHistory = "recipient-list-history"
        
        case session = "session"
        
        case aib = "aib"
        
        case earlySession = "early-session"
        
        case recipientList = "recipient-list"
        
        case notification = "notification"
        
        case byReference = "by-reference"
        
        case infoPackage = "info-package"
        
        case recordingSession = "recording-session"
        
        public var headerValueString: String {
            return self.rawValue
        }
        
    }
    
}
