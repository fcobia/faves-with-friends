//
//  PreviewMovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import Foundation


#if DEBUG
final class PreviewMovieNetworkManager: MovieNetworkManager {
	
	// Search
	func search(query: String, type: SearchType, page: Int) async throws -> MovieDBSearchResults {
		return MockMultiSearchJSON.parsed()
	}
	

	// MARK: - Movie
	func movieDetails(id: Int) async throws -> Movie {
		return MockMovieDetailJSON.parsed()
	}
	
	func movieRecommendations(id: Int, page: Int) async throws -> MovieSearchResults {
		fatalError("Not implemented")
	}
	

	// MARK: - TV
	func tvDetails(id: Int) async throws -> TV {
		fatalError("Not implemented")
	}
	
	func tvRecommendations(id: Int, page: Int) async throws -> TVSearchResults {
		fatalError("Not implemented")
	}
}
#endif
