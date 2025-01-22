//
//  ErrorMapper.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 23/1/25.
//

struct ErrorMapper {
    static func mapError(statusCode: Int?, error: Error?) -> ApiError {
        if let error = error {
            return .networkError(error)
        }
        
        guard let statusCode = statusCode else {
            return .unknown
        }
        
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 500...599: return .serverError
        default: return .unknown
        }
    }
}
