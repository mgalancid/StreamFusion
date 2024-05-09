//
//  ServiceProtocol.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/05/2024.
//

import Foundation

protocol ServiceProtocol {
    func queryMoviesAndShows(title: String) async throws -> (Data, URLResponse)
}
