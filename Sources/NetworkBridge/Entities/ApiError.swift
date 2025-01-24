//
//  DomainError.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 23/1/25.
//

import Foundation

public enum ApiError: Error {
    case invalidURL
    case badRequest       // 400
    case unauthorized     // 401
    case forbidden        // 403
    case notFound         // 404
    case serverError      // 500+
    case unknown          // Other errors
    case decodingFailed
    case networkError(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .badRequest:
            return "Bad request. Please try again."
        case .unauthorized:
            return "Unauthorized access. Please check your credentials."
        case .forbidden:
            return "You don't have permission to access this resource."
        case .notFound:
            return "The requested resource was not found."
        case .serverError:
            return "Server error. Please try again later."
        case .unknown:
            return "An unknown error occurred."
        case .decodingFailed:
            return "Failed to process the response data."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
