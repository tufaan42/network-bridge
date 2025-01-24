import Foundation

public class NetworkBridge {
    private let commonHeaders: [String: String]
    private let errorMapper: ErrorMapper
    
    public init(commonHeaders: [String: String], errorMapper: ErrorMapper = DefaultErrorMapper()) {
        self.commonHeaders = commonHeaders
        self.errorMapper = errorMapper
    }
    
    // Expose specific request classes
    public func getRequest() -> GetRequest {
        return GetRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    public func postRequest() -> PostRequest {
        return PostRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    public func putRequest() -> PutRequest {
        return PutRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    public func deleteRequest() -> DeleteRequest {
        return DeleteRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
}
