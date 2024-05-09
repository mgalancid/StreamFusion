//
//  HomePageViewModel.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/02/2024.
//

import Foundation

class HomePageViewModel {
    private let service: APIService
    var movieAndShow: APIResponse.Data.MovieAndShow?
    var updateHandler: (([APIResponse.Data.MovieAndShow]) -> Void)?
    
    init(service: APIService) {
        self.service = service
    }
    
    func fetchResults(title: String) async {
        do {
            let (data, response) = try await service.queryMoviesAndShows(title: title)
            
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(APIResponse.self, from: data)
            self.movieAndShow = decodedResponse.data.d.first
            self.updateHandler?(decodedResponse.data.d)
        } catch {
            print("Error al fetchear peliculas o series: \(error)")
        }
    }
}
