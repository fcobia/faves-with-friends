//
//  TVRecommendationsDataSource.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import Foundation


final class TVRecommendationsDataSource: ViewDataSource {
	
	// MARK: Private Variables
	private var tvId: Int = -1
	
	
	// MARK: ViewDataSource Functions
	
	func inject(tvId: Int) {
		self.tvId = tvId
	}

	override func performFetch(page: Int) async throws -> MovieDBSearchResults {
		try await self.movieNetworkManager.tvRecommendations(id: tvId, page: page)
	}
}
