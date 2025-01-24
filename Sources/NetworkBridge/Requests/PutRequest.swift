//
//  PutRequest.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 24/1/25.
//

import Foundation

class PutRequest: BaseRequest {
    func execute<T: Codable, U: Codable>(
        url: String,
        body: U,
        completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        setCommonHeaders(request: &request)
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.decodingFailed))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let apiError = self.handleError(statusCode: statusCode, error: error) {
                completion(.failure(apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}
