//
//  DeleteRequest.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 24/1/25.
//

import Foundation

public class DeleteRequest: BaseRequest {
    func execute<T: Codable>(
        url: String,
        completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        setCommonHeaders(request: &request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }

            let statusCode = httpResponse.statusCode
            
            if !(200..<300).contains(statusCode) {
                if let apiError = self.handleError(statusCode: statusCode, error: error) {
                    completion(.failure(apiError))
                } else {
                    completion(.failure(.unknown))
                }
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
