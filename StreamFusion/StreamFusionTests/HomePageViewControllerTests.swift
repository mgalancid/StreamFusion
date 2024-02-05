//
//  HomePageViewControllerTests.swift
//  StreamFusionTests
//
//  Created by Lautaro Galan on 04/02/2024.
//

import XCTest
@testable import StreamFusion

final class HomePageViewControllerTests: XCTestCase {
    var sut: HomePageViewController!

    override func setUpWithError() throws {
        sut = HomePageViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSearchBar_WhenGivenEmptySearch_ShouldReturnEmpty() {
        //Act
        sut.searchBar(sut.searchBar, textDidChange: "")
        
        //Assert
        XCTAssertEqual(sut.filteredMovies, sut.moviesAndShows, "Cuando el searchText este vacio, filteredMovies debería ser igual a moviesAndShow")
    }
    
    func testSearchBar_WhenGivenInput_ShouldReturnFetchedResult() {
        //Arrange
        sut.moviesAndShows = ["Pelicula 1", "Pelicula 2", "Show 1", "Show 2"]
        let searchText = "pelicula 1"
        
        //Act
        sut.searchBar(sut.searchBar, textDidChange: searchText)
        let expectedResult = sut.moviesAndShows.filter {
            $0.lowercased().contains(searchText.lowercased())
        }
        
        //Assert
        XCTAssertEqual(sut.filteredMovies, expectedResult, "Al realizar la busqueda, el filtrado tiene que ser igual al resultado esperado")
    }
}
