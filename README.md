[![Build Status](https://travis-ci.org/Vladlex/BodyBuilder.svg?branch=master)](https://travis-ci.org/Vladlex/BodyBuilder)


# BodyBuilder

BodyBuilder is a small framework helping you create URLRequest http body and print it's description.
Become stronger with BodyBuilder! 💪

## What problems does this framework solves?

1. Creating Headers with names, values and attributes minimizing risk of mispelling.
2. Viewing request body untill you put into request.
3. Respecting common and frequently used headers names/values/attributes still having ability to set your very custom data. 

## In details: Creating and using headers

Header is a line entry with name, value and list of parameters. For some of header names values are predefinedm for some of header-value pairs values are predefined too.

### Header Names

#### Using
Header.Name is probably most frequently class using in this framework. 
The most frequently used frameworks are predefined. 

```Swift
// Create you header by passing an static variable
let authHeader = HeaderField.init(.authorization, value: .with("Basic 123456789"))
```
#### Custom
Moreover, you can add your very custom headers very easy.
```Swift
// Add your custom header in your product by making extension of Header.Name:
extension Header.Name {
    public static let myHeaderField = HeaderField.Name.init("My-Header-Field")
}

// Use it in code like other predefined headers!
let header = HeaderField.init(.myHeaderField, value: .with("My value"))
```

### Header Values

#### Using
The trivial way to pass value is to init Header.Value with rawValue:
```Swift
let header = HeaderField.init(.accept, value: HeaderField.Value.init("text/plain"))
```

Or more shortly:
```Swift
let header1 = HeaderField.init(.accept, value: .init("text/plain"))

// '.with' is just a static method for using with autocompletion which mixed Header.Value inits with other init methods sometimes.
let header2 = HeaderField.init(.accept, value: .with("text/plain"))

```

#### Custom
Header.Value can hold **any** value which is HeaderValueRepresentable (returns headerValueString)

```Swift
public enum Direction: String, HeaderValueRepresentable {
    case forward = "fwd"
    case left = "lft"
    case right = "rgh"

    public var headerValueString: String {
        return self.rawValue
    }
}

/// Direction: fwd
let header = HeaderField.init(name: "Direction", value: .init(Direction.forward))
```

#### Predefined

Some values are predefined. Depending on using, they can be an option sets:
```Swift
let header = HeaderField.init(.allow, value: .allow([.get, .head]))
```

Enums:
```Swift
let header = HeaderField.init(.cacheControl, value: .cacheControl(.rules(.maxAge(seconds: 14),
                                                                         .maxStale(seconds: nil),
                                                                         .mustRevalidate)))
```

Or anything else as long as it conforms HeaderValueRepresentable

### Attributes
Attributes can be vary in a very wide range, but you still have a couple of helping abilities like contentDisposition which is frequently used to put some file (i. e. image) into body.

```Swift
// name is String, filename is String?
// This method respects optional filename, so you can pass nullability testing which would be required for creating array.
let header = HeaderField.init(.contentDisposition,
                                       value: .contentDisposition(.formData),
                                       attributes: .contentDisposition(.name(name, filename: filename)))
```


## In Details: Readbility

in URLRequest httpBodt is just a Data and in most cases it's just a utf-8 encoded string, so you can decode it and read.
But when you adding some file data into body – it can become undecodable or, at least, hard to read.
Well, now you can easily put data into a body and looks to description and it will look nice:

```Swift
var body = Body()
var dispositionHeader = HeaderField.init(.contentDisposition,
                                             value: .contentDisposition(.formData))
dispositionHeader.attributes = .contentDisposition(name: "\"File\"", filename: "\"file1.zip\"")
body.append(byHeaderField: dispositionHeader)
body.append(byHeaderField: .init(.contentType, value: .with("application/zip")), lineBreaks: 2)


/*
Content-Disposition: form-data; name="File"; filename="file1.zip"
Content-Type: application/zip

*/
print(body)

let fileUrl = Bundle(for: type(of: self)).url(forResource: "BodyBuilder.h", withExtension: "zip")!
let file = try! Data.init(contentsOf: fileUrl)
body.append(by: file)
/*
Content-Disposition: form-data; name="File"; filename="file1.zip"
Content-Type: application/zip

<Bytes (length: 431 bytes)>
*/
print(body)
```

### Custom body items

You can declare your custom items by adopting it to conform *BodyItemRepresentable* protocol:

```Swift
public struct File: BodyItemRepresentable {
    var filename: String
    var data: Data
    var url: URL

    public init(url: URL) {
        self.url = url
        self.filename = url.lastPathComponent
        self.data = try! Data.init(contentsOf: url)
    }

    public var httpRequestBodyData: Data {
        return data
    }

    public var httpRequestBodyDescription: String {
        return "File data from \(url)"
    }
}


let fileUrl = Bundle(for: type(of: self)).url(forResource: "BodyBuilder.h", withExtension: "zip")!
let file = File.init(url: fileUrl)
var body = Body()
body.append(by: file)

/*
File data from <path...>/BodyBuilder.h.zip
*/
print(body)
    
```


