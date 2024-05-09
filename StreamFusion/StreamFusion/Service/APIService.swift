//
//  APIService.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/02/2024.
//

import Foundation

class APIService: ServiceProtocol {
    private var baseURL = APIConstants().baseURL
    private var headers = APIConstants().headers
    
    enum ServiceError: Error {
        case invalidURL
        case requestFailed(Error)
    }
    
    func queryMoviesAndShows(title: String) async throws -> (Data, URLResponse) {
        let endpoint = "/auto-complete?q=\(title)"
        guard let url = URL(string: baseURL + endpoint) else {
            throw ServiceError.invalidURL
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return (data, response)
        } catch  {
            throw ServiceError.requestFailed(error)
        }
    }
}
