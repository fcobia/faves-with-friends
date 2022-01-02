//
//  MovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation
import HTTPServiceCore
import HTTPServiceFoundation


protocol MovieNetworkManager {
	
	// MARK: Search
	func search(query: String, type: SearchType, page: Int) async throws -> MovieDBSearchResults

	// MARK: Movie
	func movieDetails(id: Int) async throws -> Movie
	func movieRecommendations(id: Int, page: Int) async throws -> MovieSearchResults

	// MARK: TV
	func tvDetails(id: Int) async throws -> TV
	func tvRecommendations(id: Int, page: Int) async throws -> TVSearchResults
}
