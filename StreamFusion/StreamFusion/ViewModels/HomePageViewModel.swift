//
//  HomePageViewModel.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 05/02/2024.
//

import Foundation

class HomePageViewModel {
    private let service: ServiceProtocol
    var movieAndShow: APIResponse.Data.MovieAndShow?
    var updateHandler: (([APIResponse.Data.MovieAndShow]) -> Void)?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchResults(title: String) {
        service.queryMoviesAndShows(title: title) { (data, response, error) in
            if let error = error {
                print("Error al fetchear peliculas o series: \(error)")
                return
            }
            
            guard let safedata = data else {
                print("Los datos no han sido encontrados.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(APIResponse.self, from: safedata)
                self.movieAndShow = response.data.d.first
                self.updateHandler?(response.data.d)
            } catch {
                print("Los datos no han sido decodificados: \(error.localizedDescription)")
            }
        }
    }
}
