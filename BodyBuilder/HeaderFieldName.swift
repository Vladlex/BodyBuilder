//
//  HeaderFieldName.swift
//  BodyBuilder
//
//  Created by Aleksei Gordeev on 25/05/2017.
//
//

import Foundation



public extension HeaderField {
    
    public class Name : RawRepresentable, Equatable, Hashable, Comparable {
        
        public private(set) var rawValue: String
        
        convenience public init(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
        
        required public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        /// :nodoc:
        public static func ==(lhs: Name, rhs: Name) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        /// :nodoc:
        public static func <(lhs: Name, rhs: Name) -> Bool {
            return rhs.rawValue < rhs.rawValue
        }
        
        /// :nodoc:
        public var hashValue: Int {
            return self.rawValue.hashValue
        }
        
    }
}


// TODO: Move part to separate file after fix: (https://bugs.swift.org/browse/SR-4389)

// Names were written mostly by descriptions from wikipedia.
// https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
public extension HeaderField.Name {
    
    public typealias Value = HeaderField.Value
    
    /**
     Accept
     
     Content-Types that are acceptable for the response.
     
     ```
     Accept: text/plain
     ```
     
     - seealso:
     [The Swift Standard Library Reference]
     (https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)
     */
    public static let accept = HeaderField.Name.init("Accept")
    
    /**
     Accept-Charset
     
     Character sets that are acceptable
     Accept-Charset: utf-8
     */
    public static let acceptCharset = HeaderField.Name.init("Accept-Charset")
    
    /**
     Accept-Datetime
     
     Acceptable version in time.
     ```
     Accept-Datetime: Thu, 31 May 2007 20:35:00 GMT
     ```
     */
    public static let acceptDatetime = HeaderField.Name.init("Accept-Datetime")
    
    /**
     Accept-Encoding
     
     List of acceptable encodings.
     
     ```
     Accept-Encoding: gzip, deflate
     ```
     
     - seealso:
     [HTTP compression]
     (https://en.wikipedia.org/wiki/HTTP_compression)
     */
    public static let acceptEncoding = HeaderField.Name.init("Accept-Encoding")
    
    /**
     Accept-Language
     
     List of acceptable human languages for response.
     
    ```
     Accept-Language: en-US
     ```
     */
    public static let acceptLanguage = HeaderField.Name.init("Accept-Language")
    
    
    /**
     Allow
     
     Valid methods for a specified resource.
     
     ```
     Allow: GET, HEAD
     ```
     */
    public static let allow = HeaderField.Name.init("Allow")
    
    /**
     Authorization
     
     Authentication credentials for HTTP authentication.
     
     - seealso:
     [HTTP authentication]
     (https://en.wikipedia.org/wiki/HTTP_authentication)
     
     ```
     Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==
     ```
     */
    public static let authorization = HeaderField.Name.init("Authorization")
    
    /**
     Cache-Control
     
     Used to specify directives that must be obeyed by all caching mechanisms along the request-response chain.
     
     - seealso:
     [Cache-Control]
     (https://en.wikipedia.org/wiki/Cache-Control)
     */
    public static let cacheControl = HeaderField.Name.init("Cache-Control")
    
    /**
     Connection
     
     Control options for the current connection and list of hop-by-hop request fields.
     
     - seealso:
     [RFC 7230]
     (https://tools.ietf.org/html/rfc7230#section-6.1)
     */
    public static let connection = HeaderField.Name.init("Connection")
    
    /**
     Cookie
     
     An HTTP cookie previously sent by the server with Set-Cookie (below).
     */
    public static let cookie = HeaderField.Name.init(rawValue: "Cookie")
    
    /**
     Content-Disposition
     
     */
    public static let contentDisposition = HeaderField.Name.init("Content-Disposition")
    
    /**
     Content-Type
     
     */
    public static let contentType = HeaderField.Name.init("Content-Type")
    
    
    /*
     
     Accept-Language	List of acceptable human languages for response. See Content negotiation.	Accept-Language: en-US	Permanent
     Accept-Datetime	Acceptable version in time.	Accept-Datetime: Thu, 31 May 2007 20:35:00 GMT	Provisional
     Authorization	Authentication credentials for HTTP authentication.	Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==	Permanent
     Cache-Control	Used to specify directives that must be obeyed by all caching mechanisms along the request-response chain.	Cache-Control: no-cache	Permanent
     Connection	Control options for the current connection and list of hop-by-hop request fields.[7]	Connection: keep-alive
     Connection: Upgrade
     
     Permanent
     Cookie	An HTTP cookie previously sent by the server with Set-Cookie (below).	Cookie: $Version=1; Skin=new;	Permanent: standard
     Content-Length	The length of the request body in octets (8-bit bytes).	Content-Length: 348	Permanent
     Content-MD5	A Base64-encoded binary MD5 sum of the content of the request body.	Content-MD5: Q2hlY2sgSW50ZWdyaXR5IQ==	Obsolete[8]
     Content-Type	The MIME type of the body of the request (used with POST and PUT requests).	Content-Type: application/x-www-form-urlencoded	Permanent
     Date	The date and time that the message was originated (in "HTTP-date" format as defined by RFC 7231 Date/Time Formats).	Date: Tue, 15 Nov 1994 08:12:31 GMT	Permanent
     Expect	Indicates that particular server behaviors are required by the client.	Expect: 100-continue	Permanent
     Forwarded	Disclose original information of a client connecting to a web server through an HTTP proxy.[9]	Forwarded: for=192.0.2.60;proto=http;by=203.0.113.43 Forwarded: for=192.0.2.43, for=198.51.100.17	Permanent
     From	The email address of the user making the request.	From: user@example.com	Permanent
     Host	The domain name of the server (for virtual hosting), and the TCP port number on which the server is listening. The port number may be omitted if the port is the standard port for the service requested.
     [10] Mandatory since HTTP/1.1.
     
     Host: en.wikipedia.org:8080
     Host: en.wikipedia.org
     
     Permanent
     If-Match	Only perform the action if the client supplied entity matches the same entity on the server. This is mainly for methods like PUT to only update a resource if it has not been modified since the user last updated it.	If-Match: "737060cd8c284d8af7ad3082f209582d"	Permanent
     If-Modified-Since	Allows a 304 Not Modified to be returned if content is unchanged.	If-Modified-Since: Sat, 29 Oct 1994 19:43:31 GMT	Permanent
     If-None-Match	Allows a 304 Not Modified to be returned if content is unchanged, see HTTP ETag.	If-None-Match: "737060cd8c284d8af7ad3082f209582d"	Permanent
     If-Range	If the entity is unchanged, send me the part(s) that I am missing; otherwise, send me the entire new entity.	If-Range: "737060cd8c284d8af7ad3082f209582d"	Permanent
     If-Unmodified-Since	Only send the response if the entity has not been modified since a specific time.	If-Unmodified-Since: Sat, 29 Oct 1994 19:43:31 GMT	Permanent
     Max-Forwards	Limit the number of times the message can be forwarded through proxies or gateways.	Max-Forwards: 10	Permanent
     Origin	Initiates a request for cross-origin resource sharing (asks server for an 'Access-Control-Allow-Origin' response field).	Origin: http://www.example-social-network.com	Permanent: standard
     Pragma	Implementation-specific fields that may have various effects anywhere along the request-response chain.	Pragma: no-cache	Permanent
     Proxy-Authorization	Authorization credentials for connecting to a proxy.	Proxy-Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==	Permanent
     Range	Request only part of an entity. Bytes are numbered from 0. See Byte serving.	Range: bytes=500-999	Permanent
     Referer [sic]	This is the address of the previous web page from which a link to the currently requested page was followed. (The word “referrer” has been misspelled in the RFC as well as in most implementations to the point that it has become standard usage and is considered correct terminology)	Referer: http://en.wikipedia.org/wiki/Main_Page	Permanent
     TE	The transfer encodings the user agent is willing to accept: the same values as for the response header field Transfer-Encoding can be used, plus the "trailers" value (related to the "chunked" transfer method) to notify the server it expects to receive additional fields in the trailer after the last, zero-sized, chunk.	TE: trailers, deflate	Permanent
     User-Agent	The user agent string of the user agent.	User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20100101 Firefox/21.0	Permanent
     Upgrade	Ask the server to upgrade to another protocol.	Upgrade: HTTP/2.0, HTTPS/1.3, IRC/6.9, RTA/x11, websocket	Permanent
     Via	Informs the server of proxies through which the request was sent.	Via: 1.0 fred, 1.1 example.com (Apache/1.1)	Permanent
     Warning	A general warning about possible problems with the entity body.	Warning: 199 Miscellaneous warning	Permanent
     
     Common non-standard request fields[edit]
     Field name	Description	Example
     X-Requested-With	mainly used to identify Ajax requests. Most JavaScript frameworks send this field with value of XMLHttpRequest	X-Requested-With: XMLHttpRequest
     DNT[11]	Requests a web application to disable their tracking of a user. This is Mozilla's version of the X-Do-Not-Track header field (since Firefox 4.0 Beta 11). Safari and IE9 also have support for this field.[12] On March 7, 2011, a draft proposal was submitted to IETF.[13] The W3C Tracking Protection Working Group is producing a specification.[14]	DNT: 1 (Do Not Track Enabled)
     DNT: 0 (Do Not Track Disabled)
     
     X-Forwarded-For[15]	a de facto standard for identifying the originating IP address of a client connecting to a web server through an HTTP proxy or load balancer	X-Forwarded-For: client1, proxy1, proxy2
     X-Forwarded-For: 129.78.138.66, 129.78.64.103
     
     X-Forwarded-Host[16]	a de facto standard for identifying the original host requested by the client in the Host HTTP request header, since the host name and/or port of the reverse proxy (load balancer) may differ from the origin server handling the request.	X-Forwarded-Host: en.wikipedia.org:8080
     X-Forwarded-Host: en.wikipedia.org
     
     X-Forwarded-Proto[17]	a de facto standard for identifying the originating protocol of an HTTP request, since a reverse proxy (or a load balancer) may communicate with a web server using HTTP even if the request to the reverse proxy is HTTPS. An alternative form of the header (X-ProxyUser-Ip) is used by Google clients talking to Google servers.	X-Forwarded-Proto: https
     Front-End-Https[18]	Non-standard header field used by Microsoft applications and load-balancers	Front-End-Https: on
     X-Http-Method-Override[19]	Requests a web application to override the method specified in the request (typically POST) with the method given in the header field (typically PUT or DELETE). This can be used when a user agent or firewall prevents PUT or DELETE methods from being sent directly (note that this is either a bug in the software component, which ought to be fixed, or an intentional configuration, in which case bypassing it may be the wrong thing to do).	X-HTTP-Method-Override: DELETE
     X-ATT-DeviceId[20]	Allows easier parsing of the MakeModel/Firmware that is usually found in the User-Agent String of AT&T Devices	X-Att-Deviceid: GT-P7320/P7320XXLPG
     X-Wap-Profile[21]	Links to an XML file on the Internet with a full description and details about the device currently connecting. In the example to the right is an XML file for an AT&T Samsung Galaxy S2.	x-wap-profile: http://wap.samsungmobile.com/uaprof/SGH-I777.xml
     Proxy-Connection[22]	Implemented as a misunderstanding of the HTTP specifications. Common because of mistakes in implementations of early HTTP versions. Has exactly the same functionality as standard Connection field.	Proxy-Connection: keep-alive
     X-UIDH[23][24][25]	Server-side deep packet insertion of a unique ID identifying customers of Verizon Wireless; also known as "perma-cookie" or "supercookie"	X-UIDH: ...
     X-Csrf-Token[26]	Used to prevent cross-site request forgery. Alternative header names are: X-CSRFToken[27] and X-XSRF-TOKEN[28]	X-Csrf-Token: i8XNjC4b8KVok4uw5RftR38Wgp2BFwql
     X-Request-ID,
     X-Correlation-ID[29]
     
     Correlates HTTP requests between a client and server.	X-Request-ID: f058ebd6-02f7-4d3f-942e-904344e8cde5
     Response fields[edit]
     Field name	Description	Example	Status
     Access-Control-Allow-Origin	Specifying which web sites can participate in cross-origin resource sharing	Access-Control-Allow-Origin: *	Provisional
     Accept-Patch[30]	Specifies which patch document formats this server supports	Accept-Patch: text/example;charset=utf-8	Permanent
     Accept-Ranges	What partial content range types this server supports via byte serving	Accept-Ranges: bytes	Permanent
     Age	The age the object has been in a proxy cache in seconds	Age: 12	Permanent
     Allow	Valid methods for a specified resource. To be used for a 405 Method not allowed	Allow: GET, HEAD	Permanent
     Alt-Svc[31]	A server uses "Alt-Svc" header (meaning Alternative Services) to indicate that its resources can also be accessed at a different network location (host or port) or using a different protocol	Alt-Svc: h2="http2.example.com:443"; ma=7200	Permanent
     Cache-Control	Tells all caching mechanisms from server to client whether they may cache this object. It is measured in seconds	Cache-Control: max-age=3600	Permanent
     Connection	Control options for the current connection and list of hop-by-hop response fields[7]	Connection: close	Permanent
     Content-Disposition[32]	An opportunity to raise a "File Download" dialogue box for a known MIME type with binary format or suggest a filename for dynamic content. Quotes are necessary with special characters.	Content-Disposition: attachment; filename="fname.ext"	Permanent
     Content-Encoding	The type of encoding used on the data. See HTTP compression.	Content-Encoding: gzip	Permanent
     Content-Language	The natural language or languages of the intended audience for the enclosed content[33]	Content-Language: da	Permanent
     Content-Length	The length of the response body in octets (8-bit bytes)	Content-Length: 348	Permanent
     Content-Location	An alternate location for the returned data	Content-Location: /index.htm	Permanent
     Content-MD5	A Base64-encoded binary MD5 sum of the content of the response	Content-MD5: Q2hlY2sgSW50ZWdyaXR5IQ==	Obsolete[8]
     Content-Range	Where in a full body message this partial message belongs	Content-Range: bytes 21010-47021/47022	Permanent
     Content-Type	The MIME type of this content	Content-Type: text/html; charset=utf-8	Permanent
     Date	The date and time that the message was sent (in "HTTP-date" format as defined by RFC 7231) [34]	Date: Tue, 15 Nov 1994 08:12:31 GMT	Permanent
     ETag	An identifier for a specific version of a resource, often a message digest	ETag: "737060cd8c284d8af7ad3082f209582d"	Permanent
     Expires	Gives the date/time after which the response is considered stale (in "HTTP-date" format as defined by RFC 7231)	Expires: Thu, 01 Dec 1994 16:00:00 GMT	Permanent: standard
     Last-Modified	The last modified date for the requested object (in "HTTP-date" format as defined by RFC 7231)	Last-Modified: Tue, 15 Nov 1994 12:45:26 GMT	Permanent
     Link	Used to express a typed relationship with another resource, where the relation type is defined by RFC 5988	Link: </feed>; rel="alternate"[35]	Permanent
     Location	Used in redirection, or when a new resource has been created.	Location: http://www.w3.org/pub/WWW/People.html	Permanent
     P3P	This field is supposed to set P3P policy, in the form of P3P:CP="your_compact_policy". However, P3P did not take off,[36] most browsers have never fully implemented it, a lot of websites set this field with fake policy text, that was enough to fool browsers the existence of P3P policy and grant permissions for third party cookies.	P3P: CP="This is not a P3P policy! See http://www.google.com/support/accounts/bin/answer.py?hl=en&answer=151657 for more info."	Permanent
     Pragma	Implementation-specific fields that may have various effects anywhere along the request-response chain.	Pragma: no-cache	Permanent
     Proxy-Authenticate	Request authentication to access the proxy.	Proxy-Authenticate: Basic	Permanent
     Public-Key-Pins[37]	HTTP Public Key Pinning, announces hash of website's authentic TLS certificate	Public-Key-Pins: max-age=2592000; pin-sha256="E9CZ9INDbd+2eRQozYqqbQ2yXLVKB9+xcprMF+44U1g=";	Permanent
     Refresh	Used in redirection, or when a new resource has been created. This refresh redirects after 5 seconds.	Refresh: 5; url=http://www.w3.org/pub/WWW/People.html	Proprietary and non-standard: a header extension introduced by Netscape and supported by most web browsers.
     Retry-After	If an entity is temporarily unavailable, this instructs the client to try again later. Value could be a specified period of time (in seconds) or a HTTP-date.[38]
     Example 1: Retry-After: 120
     Example 2: Retry-After: Fri, 07 Nov 2014 23:59:59 GMT
     Permanent
     
     Server	A name for the server	Server: Apache/2.4.1 (Unix)	Permanent
     Set-Cookie	An HTTP cookie	Set-Cookie: UserID=JohnDoe; Max-Age=3600; Version=1	Permanent: standard
     Strict-Transport-Security	A HSTS Policy informing the HTTP client how long to cache the HTTPS only policy and whether this applies to subdomains.	Strict-Transport-Security: max-age=16070400; includeSubDomains	Permanent: standard
     Trailer	The Trailer general field value indicates that the given set of header fields is present in the trailer of a message encoded with chunked transfer coding.	Trailer: Max-Forwards	Permanent
     Transfer-Encoding	The form of encoding used to safely transfer the entity to the user. Currently defined methods are: chunked, compress, deflate, gzip, identity.	Transfer-Encoding: chunked	Permanent
     TSV	Tracking Status Value, value suggested to be sent in response to a DNT(do-not-track), possible values:
     "!" — under construction
     "?" — dynamic
     "G" — gateway to multiple parties
     "N" — not tracking
     "T" — tracking
     "C" — tracking with consent
     "P" — tracking only if consented
     "D" — disregarding DNT
     "U" — updated
     TSV: ?	Permanent
     Upgrade	Ask the client to upgrade to another protocol.	Upgrade: HTTP/2.0, HTTPS/1.3, IRC/6.9, RTA/x11, websocket	Permanent
     Vary	Tells downstream proxies how to match future request headers to decide whether the cached response can be used rather than requesting a fresh one from the origin server.
     Example 1: Vary: *
     Example 2: Vary: Accept-Language
     Permanent
     Via	Informs the client of proxies through which the response was sent.	Via: 1.0 fred, 1.1 example.com (Apache/1.1)	Permanent
     Warning	A general warning about possible problems with the entity body.	Warning: 199 Miscellaneous warning	Permanent
     WWW-Authenticate	Indicates the authentication scheme that should be used to access the requested entity.	WWW-Authenticate: Basic	Permanent
     X-Frame-Options[39]	Clickjacking protection: deny - no rendering within a frame, sameorigin - no rendering if origin mismatch, allow-from - allow from specified location, allowall - non-standard, allow from any location	X-Frame-Options: deny	Obsolete[40]
     Common non-standard response fields[edit]
     Field name	Description	Example
     Status	CGI header field specifying the status of the HTTP response. Normal HTTP responses use a separate "Status-Line" instead, defined by RFC 7230.[41]	Status: 200 OK
     X-XSS-Protection[42]	Cross-site scripting (XSS) filter	X-XSS-Protection: 1; mode=block
     Content-Security-Policy, X-Content-Security-Policy, X-WebKit-CSP[43]	Content Security Policy definition.	X-WebKit-CSP: default-src 'self'
     X-Content-Type-Options[44]	The only defined value, "nosniff", prevents Internet Explorer from MIME-sniffing a response away from the declared content-type. This also applies to Google Chrome, when downloading extensions.[45]	X-Content-Type-Options: nosniff[46]
     X-Powered-By[47]	Specifies the technology (e.g. ASP.NET, PHP, JBoss) supporting the web application (version details are often in X-Runtime, X-Version, or X-AspNet-Version)	X-Powered-By: PHP/5.4.0
     X-UA-Compatible[48]	Recommends the preferred rendering engine (often a backward-compatibility mode) to use to display the content. Also used to activate Chrome Frame in Internet Explorer.	X-UA-Compatible: IE=EmulateIE7
     X-UA-Compatible: IE=edge
     X-UA-Compatible: Chrome=1
     X-Content-Duration[49]	Provide the duration of the audio or video in seconds; only supported by Gecko browsers	X-Content-Duration: 42.666
     Upgrade-Insecure-Requests[50]	Tells a server which (presumably in the middle of a HTTP -> HTTPS migration) hosts mixed content that the client would prefer redirection to HTTPS and can handle Content-Security-Policy: upgrade-insecure-requests	Upgrade-Insecure-Requests: 1
     X-Request-ID,
     X-Correlation-ID[51]
     
     Correlates HTTP requests between a client and server.	X-Request-ID: f058ebd6-02f7-4d3f-942e-904344e8cde5
     */
}
