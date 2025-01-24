import Foundation

public class NetworkBridge {
    private let commonHeaders: [String: String]
    private let errorMapper: ErrorMapper
    
    init(commonHeaders: [String: String], errorMapper: ErrorMapper = DefaultErrorMapper()) {
        self.commonHeaders = commonHeaders
        self.errorMapper = errorMapper
    }
    
    // Expose specific request classes
    func getRequest() -> GetRequest {
        return GetRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    func postRequest() -> PostRequest {
        return PostRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    func putRequest() -> PutRequest {
        return PutRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
    
    func deleteRequest() -> DeleteRequest {
        return DeleteRequest(commonHeaders: commonHeaders, errorMapper: errorMapper)
    }
}
