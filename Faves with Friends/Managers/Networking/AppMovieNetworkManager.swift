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
	
	public func search(query: String, type: SearchType) async throws -> MovieDBSearchResults {
		switch type {
				
			case .all:
				return try await movieNetworkService.fetch(.multiSearch(query: query))
				
			case .movies:
				return try await movieNetworkService.fetch(.movieSearch(query: query))
				
			case .tv:
				return try await movieNetworkService.fetch(.tvSearch(query: query))
				
			case .person:
				return try await movieNetworkService.fetch(.personSearch(query: query))
		}
	}
}


// MARK: - Service Paths
extension SimpleHTTPServicePath {
	static private let basePath = "/3/"
	
	static fileprivate let details			= SimpleHTTPServicePath("\(basePath)movie")
	static fileprivate let multiSearch    	= SimpleHTTPServicePath("\(basePath)search/multi")
	static fileprivate let movieSearch    	= SimpleHTTPServicePath("\(basePath)search/movie")
	static fileprivate let tvSearch			= SimpleHTTPServicePath("\(basePath)search/tv")
	static fileprivate let personSearch		= SimpleHTTPServicePath("\(basePath)search/person")
}


// MARK: - Service Tasks
extension SimpleHTTPJSONServiceTask {
	
	// Task Convenience Methods
	
	static fileprivate func details(id: Int) -> SimpleHTTPJSONServiceTask<Movie> {
		return .init(path: .details.addingPath("\(id)"), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func multiSearch(query: String) -> SimpleHTTPJSONServiceTask<MultiSearchResults> {
		let query = URLQueryItem(name: "query", value: query)
		return .init(path: .multiSearch, httpMethod: .get([query]), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func movieSearch(query: String) -> SimpleHTTPJSONServiceTask<MovieSearchResults> {
		let query = URLQueryItem(name: "query", value: query)
		return .init(path: .movieSearch, httpMethod: .get([query]), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}

	static fileprivate func tvSearch(query: String) -> SimpleHTTPJSONServiceTask<TVSearchResults> {
		let query = URLQueryItem(name: "query", value: query)
		return .init(path: .tvSearch, httpMethod: .get([query]), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func personSearch(query: String) -> SimpleHTTPJSONServiceTask<PersonSearchResults> {
		let query = URLQueryItem(name: "query", value: query)
		return .init(path: .personSearch, httpMethod: .get([query]), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
}
