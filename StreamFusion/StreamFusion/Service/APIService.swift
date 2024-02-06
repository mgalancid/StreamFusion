//
//  APIService.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/02/2024.
//

import Foundation

protocol ServiceProtocol {
    func queryMoviesAndShows(title: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class APIService: ServiceProtocol {
    private var baseURL = APIConstants().baseURL
    private var headers = APIConstants().headers
    
    func queryMoviesAndShows(title: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let endpoint = "/auto-complete?q=\(title)"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        dataTask.resume()
    }
}
