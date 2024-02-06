//
//  HomePageViewControllerTests.swift
//  StreamFusionTests
//
//  Created by Lautaro Galan on 04/02/2024.
//

import XCTest
@testable import StreamFusion

final class HomePageViewControllerTests: XCTestCase {
    var service: MockService!
    var sut: HomePageViewController!

    override func setUpWithError() throws {
        service = MockService()
        sut = HomePageViewController()
    }

    override func tearDownWithError() throws {
        service = nil
        sut = nil
    }
    
    func testSearchBar_WhenGivenEmptySearch_ShouldReturnEmpty() {
        //Arrange
        let expectation = self.expectation(description: "Buscar peliculas y series")
        var responseData: Data?
        service.queryMoviesAndShows(title: "") { data, _, _ in
            responseData = nil
            expectation.fulfill()
        }
        
        //Act
        sut.searchBar(sut.searchBar, textDidChange: "")
        
        waitForExpectations(timeout: 5, handler: nil)
        
        //Assert
        XCTAssertNil(responseData, "El searchbar esta vacio")
        XCTAssertEqual(sut.filteredMovies, sut.moviesAndShows, "Cuando el searchText este vacio, filteredMovies debería ser igual a moviesAndShow")
    }
    
    func testSearchBar_WhenGivenInput_ShouldReturnFetchedResult() {
        //Arrange
        let expecation = self.expectation(description: "Buscar la pelicula o serie preferida")
        var responseData: Data?
        let searchText = "pelicula 1"
        service.queryMoviesAndShows(title: searchText) { data, _, _ in
            responseData = data
            expecation.fulfill()
        }

        //Act
        sut.searchBar(sut.searchBar, textDidChange: searchText)
        let expectedResult = sut.moviesAndShows.filter {
            $0.l.contains(searchText)
        }
        
        waitForExpectations(timeout: 5, handler: nil)

        
        //Assert
        XCTAssertNotNil(responseData, "El searchbar no esta vacio")
        XCTAssertEqual(sut.filteredMovies, expectedResult, "Al realizar la busqueda, el filtrado tiene que ser igual al resultado esperado")
    }
}

class MockService: ServiceProtocol {
    func queryMoviesAndShows(title: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let mockData = [
                ["id": "1", "l": "Pelicula 1", "q": nil, "i": nil],
                ["id": "2", "l": "Pelicula 2", "q": nil, "i": nil],
                ["id": "3", "l": "Serie 1", "q": nil, "i": nil],
                ["id": "4", "l": "Serie 2", "q": nil, "i": nil]
            ]
        do {
            let data = try JSONSerialization.data(withJSONObject: mockData)
            completion(data, nil, nil)
        } catch {
            print("Error: \(error)")
            completion(nil, nil, error)
        }
    }
}
