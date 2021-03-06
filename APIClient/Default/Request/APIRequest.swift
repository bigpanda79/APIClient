import Foundation

public enum APIRequestMethod: UInt {
    
    case options, get, head, post, put, patch, delete, trace, connect
    
}

public typealias ProgressHandler = (Progress) -> ()
public protocol APIRequestEncoding {}

public protocol APIRequest {
    
    var path: String { get }
    var method: APIRequestMethod { get }
    var encoding: APIRequestEncoding? { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var multipartFormData: ((MultipartFormDataType) -> Void)? { get }
    var progressHandler: ProgressHandler? { get }
    
}

public protocol MultipartFormDataType {
    
    var contentType: String { get }
    var contentLength: UInt64 { get }
    var boundary: String { get }
    
    func append(_ data: Data, withName name: String)
    func append(_ data: Data, withName name: String, mimeType: String)
    func append(_ data: Data, withName name: String, fileName: String, mimeType: String)
    func append(_ fileURL: URL, withName name: String)
    func append(_ fileURL: URL, withName name: String, fileName: String, mimeType: String)
    func append(_ stream: InputStream, withLength length: UInt64, name: String, fileName: String, mimeType: String)
    func append(_ stream: InputStream, withLength length: UInt64, headers: [String: String])
    
}

public protocol SerializeableAPIRequest: APIRequest {
    
    associatedtype Parser: ResponseParser

    var parser: Parser { get }
    
}

public extension APIRequest {

    var method: APIRequestMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }

    var encoding: APIRequestEncoding? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var multipartFormData: ((MultipartFormDataType) -> Void)? {
        return nil
    }
    
    var progressHandler: ProgressHandler? {
        return nil
    }

}
