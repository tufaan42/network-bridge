import Foundation

class NetworkBridge {
    let errorMapper: ErrorMapper
    
    init(errorMapper: ErrorMapper = DefaultErrorMapper()) {
        self.errorMapper = errorMapper
    }
    
    func get<T: Codable>(url: String, completion: @escaping (Result<T, ApiError>) -> Void) {
        // Validate URL
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        // Create URLRequest
        let request = URLRequest(url: url)

        // Perform network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode

            // Map errors using the ErrorMapper
            if let mappedError = self.errorMapper.mapError(statusCode: statusCode, error: error) as? ApiError {
                completion(.failure(mappedError))
                return
            }

            // Decode response
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
    
    func post<T: Codable, U: Codable>(
            url: String,
            body: U,
            completion: @escaping (Result<T, ApiError>) -> Void
        ) {
            // Validate URL
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }

            // Create URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Encode the request body
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.decodingFailed))
                return
            }

            // Perform network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                let statusCode = (response as? HTTPURLResponse)?.statusCode

                // Map errors using the ErrorMapper
                if let mappedError = self.errorMapper.mapError(statusCode: statusCode, error: error) as? ApiError {
                    completion(.failure(mappedError))
                    return
                }

                // Decode response
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
