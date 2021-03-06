//
//  Faves_with_FriendsTests.swift
//  Faves with FriendsTests
//
//  Created by Frank Cobia on 11/24/21.
//

import XCTest
@testable import Faves_with_Friends


class Faves_with_FriendsTests: XCTestCase {
	
	// MARK: Variables
	private var movieNetworkManager: MovieNetworkManager!

	
	// MARK: Setup and Teardown
	
    override func setUpWithError() throws {
		let userManager = TemporaryUserManager()
		let httpService = MovieHTTPService(url: URL(string: "https://api.themoviedb.org")!, userManager: userManager, retryCount: 0)
		
		movieNetworkManager = AppMovieNetworkManager(movieNetworkService: httpService)
    }
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	
	// MARK: Tests

    func testExample() async throws {
		let movie = try await movieNetworkManager.movieDetails(id: 550)
		XCTAssert(movie.id == 550)
		XCTAssert(movie.title == "Fight Club")
    }
	
	func testMovieSearch() async throws {
		let movies = try await movieNetworkManager.search(query: "Star Wars", type: .movies, page: 0)
		print(movies)
		XCTAssert(movies.results.count > 0)
	}
	
	func testTVSeason() async throws {
		let season = try await movieNetworkManager.tvSeason(id: 67198, seasonNumber: 1)
		print("\(String(describing: season))")
		XCTAssertNotNil(season)
	}
}
