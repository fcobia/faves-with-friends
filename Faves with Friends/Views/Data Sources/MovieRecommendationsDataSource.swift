//
//  MovieRecommendationsDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import Foundation


final class MovieRecommendationsDataSource: ViewDataSource {
	
	// MARK: Private Variables
	private var movieId: Int = -1
	
	
	// MARK: Init
	override init() {
		super.init()
	}
	
	func inject(movieId: Int) {
		self.movieId = movieId
	}

	
	// MARK: ViewDataSource Functions
	
	override func performFetch(page: Int) async throws -> MovieDBSearchResults {
		return try await self.movieNetworkManager.movieRecommendations(id: movieId, page: page)
	}
}
