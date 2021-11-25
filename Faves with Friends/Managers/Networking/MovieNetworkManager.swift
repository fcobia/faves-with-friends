//
//  MovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation
import HTTPServiceCore
import HTTPServiceFoundation


final class MovieNetworkManager {
	
	// MARK: Private Variables
	private let movieNetworkService: AppNetworkService
	
	
	// MARK: Init
	
	init(movieNetworkService: AppNetworkService) {
		self.movieNetworkService = movieNetworkService
	}
	
	
	// MARK: Public Methods
	
	public func movieDetails(id: Int) async throws -> Movie {
		return try await movieNetworkService.fetch(.details(id: id))
	}
}


// MARK: - Service Paths
extension SimpleHTTPServicePath {
	static private let basePath = "/3/"
	
	static fileprivate let details	= SimpleHTTPServicePath("\(basePath)movie")
}


// MARK: - Service Tasks
extension SimpleHTTPJSONServiceTask {
	
	static fileprivate func details(id: Int) -> SimpleHTTPJSONServiceTask<Movie> {
		return .init(path: .details.addingPath("\(id)"), httpMethod: .get())
	}
}
