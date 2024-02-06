//
//  MoviesAndShows.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/02/2024.
//

import Foundation

struct APIResponse: Codable {
    let data: Data
    let message: String
    let status: Bool
    
    struct Data: Codable {
        let d: [MovieAndShow]
        let v: Int
        let q: String
        
        struct MovieAndShow: Codable {
            struct Image: Codable {
                let width: Int
                let height: Int
                let imageUrl: String
            }
            
            let id: String
            let l: String
            let q: String?
            let i: Image?
        }
    }
}

extension APIResponse.Data.MovieAndShow: Equatable {
    static func == (lhs: APIResponse.Data.MovieAndShow, rhs: APIResponse.Data.MovieAndShow) -> Bool {
        return lhs.id == rhs.id && lhs.l == rhs.l && lhs.q == rhs.q
    }
}

