//
//  BaseRequest.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 24/1/25.
//

import Foundation

class BaseRequest {
    let errorMapper: ErrorMapper
    let commonHeaders: [String: String]
    
    init(commonHeaders: [String: String], errorMapper: ErrorMapper) {
        self.commonHeaders = commonHeaders
        self.errorMapper = errorMapper
    }
    
    // Set common headers for the request
    func setCommonHeaders(request: inout URLRequest) {
        for header in commonHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    // Handle errors
    func handleError(statusCode: Int?, error: Error?) -> ApiError? {
        return self.errorMapper.mapError(statusCode: statusCode, error: error) as? ApiError
    }
}
