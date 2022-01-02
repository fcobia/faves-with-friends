//
//  MovieRecommendationsDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import Foundation


final class MovieRecommendationsDataSource: ViewDataSource {
	
	// MARK: Private Variables
	private let movieId: Int
	
	
	// MARK: Init
	init(movieId: Int) {
		self.movieId = movieId
	}

	
	// MARK: ViewDataSource Functions
	
	override func performFetch(page: Int) async throws -> MovieDBSearchResults {
		try await self.movieNetworkManager.movieRecommendations(id: movieId, page: page)
	}
}
