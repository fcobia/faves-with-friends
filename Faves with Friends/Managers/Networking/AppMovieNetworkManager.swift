//
//  AppMovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/30/21.
//

import Foundation
import HTTPServiceCore
import HTTPServiceFoundation


final class AppMovieNetworkManager: MovieNetworkManager {
	
	// MARK: Private Variables
	private let movieNetworkService: NetworkService
	
	
	// MARK: Init
	
	init(movieNetworkService: NetworkService) {
		self.movieNetworkService = movieNetworkService
	}
	
	
	// MARK: Public Methods
	
	public func movieDetails(id: Int) async throws -> Movie {
		return try await movieNetworkService.fetch(.details(id: id))
	}
	
	public func movieSearch(query: String) async throws -> MovieSearchResult {
		return try await movieNetworkService.fetch(.movieSearch(query: query))
	}
}


// MARK: - Service Paths
extension SimpleHTTPServicePath {
	static private let basePath = "/3/"
	
	static fileprivate let details	= SimpleHTTPServicePath("\(basePath)movie")
	static fileprivate let movieSearch    = SimpleHTTPServicePath("\(basePath)search/movie")
}


// MARK: - Service Tasks
extension SimpleHTTPJSONServiceTask {
	
	// Task Convenience Methods
	
	static fileprivate func details(id: Int) -> SimpleHTTPJSONServiceTask<Movie> {
		return .init(path: .details.addingPath("\(id)"), httpMethod: .get(), jsonDecoder: movieJSONDecoder)
	}
	
	static fileprivate func movieSearch(query: String) -> SimpleHTTPJSONServiceTask<MovieSearchResult> {
		let query = URLQueryItem(name: "query", value: query)
		return .init(path: .movieSearch, httpMethod: .get([query]), jsonDecoder: movieJSONDecoder)
	}
}


// Private Static Variables
private let movieJSONDecoder: JSONDecoder = {
	let df = DateFormatter()
	df.dateFormat = "yyyy-MM-dd"

	let decoder = JSONDecoder()
	decoder.dateDecodingStrategy = .formatted(DateFormatters.dateOnly)
	
	return decoder
}()
