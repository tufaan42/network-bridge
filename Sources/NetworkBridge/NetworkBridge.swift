import Foundation

class NetworkBridge {
    let errorMapper: ErrorMapper
    private(set) var commonHeaders: [String: String] = [:]
    
    init(commonHeaders: [String: String], errorMapper: ErrorMapper = DefaultErrorMapper()) {
        self.commonHeaders = commonHeaders
        self.errorMapper = errorMapper
    }
    
    
    // MARK: GET Request
    func get<T: Codable>(url: String, completion: @escaping (Result<T, ApiError>) -> Void) {
        // Validate URL
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setCommonHeaders(request: &request)

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
    
    // MARK: POST Request
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
            setCommonHeaders(request: &request)
            
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
    
    // MARK: PUT Request
    func put<T: Codable, U: Codable>(
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
            request.httpMethod = "PUT"
            setCommonHeaders(request: &request)
            
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
    
    // MARK: DELETE Request
    func delete<T: Codable>(
        url: String,
        completion: @escaping (Result<T, ApiError>) -> Void
    ) {
        // Validate URL
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        setCommonHeaders(request: &request)

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
    
    private func setCommonHeaders(request: inout URLRequest) {
        for header in commonHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    func setAuthorizationHeader(token: String) {
        commonHeaders["Authorization"] = "Bearer \(token)"
    }
    
    func addHeaders(headers: [String:String]) {
        for header in headers {
            commonHeaders[header.key] = header.value
        }
    }
}
