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
	
	
	// MARK: Search
	
	public func search(query: String, type: SearchType, page: Int) async throws -> MovieDBSearchResults {
		let pageToUse = page + 1
		
		switch type {
				
			case .all:
				return try await movieNetworkService.fetch(.multiSearch(query: query, page: pageToUse))
				
			case .movies:
				return try await movieNetworkService.fetch(.movieSearch(query: query, page: pageToUse))
				
			case .tv:
				return try await movieNetworkService.fetch(.tvSearch(query: query, page: pageToUse))
				
			case .person:
				return try await movieNetworkService.fetch(.personSearch(query: query, page: pageToUse))
		}
	}


	// MARK: Movie

	public func movieDetails(id: Int) async throws -> Movie {
		return try await movieNetworkService.fetch(.movieDetails(id: id))
	}

	func movieRecommendations(id: Int, page: Int) async throws -> MovieSearchResults {
		let pageToUse = page + 1
		
		return try await movieNetworkService.fetch(.movieRecommendations(id: id, page: pageToUse))
	}

	func movieCredits(id: Int) async throws -> Credits {
		return try await movieNetworkService.fetch(.movieCredits(id: id))
	}
	
	func movieWhereToWatch(id: Int) async throws -> WhereToWatch? {
		let search = try await movieNetworkService.fetch(.movieWhereToWatch(id: id))
		
		return search.result
	}

	
	// MARK: TV

	public func tvDetails(id: Int) async throws -> TV {
		return try await movieNetworkService.fetch(.tvDetails(id: id))
	}

	func tvRecommendations(id: Int, page: Int) async throws -> TVSearchResults {
		let pageToUse = page + 1
		
		return try await movieNetworkService.fetch(.tvRecommendations(id: id, page: pageToUse))
	}

	func tvCredits(id: Int) async throws -> Credits {
		return try await movieNetworkService.fetch(.tvCredits(id: id))
	}
	
	func tvWhereToWatch(id: Int) async throws -> WhereToWatch? {
		let search = try await movieNetworkService.fetch(.tvWhereToWatch(id: id))
		
		return search.result
	}

	
	// MARK: People

	public func peopleDetails(id: Int) async throws -> Person {
		return try await movieNetworkService.fetch(.peopleDetails(id: id))
	}

	func peopleMovieCredits(id: Int) async throws -> PersonCredits {
		return try await movieNetworkService.fetch(.peopleMovieCredits(id: id))
	}

	func peopleTVCredits(id: Int) async throws -> PersonCredits {
		return try await movieNetworkService.fetch(.peopleTVCredits(id: id))
	}

	func peopleCombinedCredits(id: Int) async throws -> PersonCredits {
		return try await movieNetworkService.fetch(.peopleCombinedCredits(id: id))
	}
}


// MARK: - Service Paths
extension SimpleHTTPServicePath {
	static private let basePath = "/3/"
	
	// Search
	static fileprivate let multiSearch    	= SimpleHTTPServicePath("\(basePath)search/multi")
	static fileprivate let movieSearch    	= SimpleHTTPServicePath("\(basePath)search/movie")
	static fileprivate let tvSearch			= SimpleHTTPServicePath("\(basePath)search/tv")
	static fileprivate let personSearch		= SimpleHTTPServicePath("\(basePath)search/person")
	
	// Movie
	static fileprivate let movieDetails			= SimpleHTTPServicePath("\(basePath)movie")
	static fileprivate let movieRecommendations	= SimpleHTTPServicePath("\(basePath)movie/{id}/recommendations")
	static fileprivate let movieCredits			= SimpleHTTPServicePath("\(basePath)movie/{id}/credits")
	static fileprivate let movieWhereToWatch	= SimpleHTTPServicePath("\(basePath)movie/{id}/watch/providers")

	// TV
	static fileprivate let tvDetails			= SimpleHTTPServicePath("\(basePath)tv")
	static fileprivate let tvRecommendations	= SimpleHTTPServicePath("\(basePath)tv/{id}/recommendations")
	static fileprivate let tvCredits			= SimpleHTTPServicePath("\(basePath)tv/{id}/credits")
	static fileprivate let tvWhereToWatch		= SimpleHTTPServicePath("\(basePath)tv/{id}/watch/providers")
	
	// People
	static fileprivate let peopleDetails			= SimpleHTTPServicePath("\(basePath)person")
	static fileprivate let peopleMovieCredits		= SimpleHTTPServicePath("\(basePath)person/{id}/movie_credits")
	static fileprivate let peopleTVCredits			= SimpleHTTPServicePath("\(basePath)person/{id}/tv_credits")
	static fileprivate let peopleCombinedCredits	= SimpleHTTPServicePath("\(basePath)person/{id}/combined_credits")
}


// MARK: - Service Tasks
extension SimpleHTTPJSONServiceTask {
	
	// Search
	
	static fileprivate func multiSearch(query: String, page: Int) -> SimpleHTTPJSONServiceTask<MultiSearchResults> {
		let query = [
			URLQueryItem(name: "query", value: query),
			URLQueryItem(name: "page", value: page.description),
		]
		return .init(path: .multiSearch, httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func movieSearch(query: String, page: Int) -> SimpleHTTPJSONServiceTask<MovieSearchResults> {
		let query = [
			URLQueryItem(name: "query", value: query),
			URLQueryItem(name: "page", value: page.description),
		]
		return .init(path: .movieSearch, httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}

	static fileprivate func tvSearch(query: String, page: Int) -> SimpleHTTPJSONServiceTask<TVSearchResults> {
		let query = [
			URLQueryItem(name: "query", value: query),
			URLQueryItem(name: "page", value: page.description),
		]
		return .init(path: .tvSearch, httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func personSearch(query: String, page: Int) -> SimpleHTTPJSONServiceTask<PersonSearchResults> {
		let query = [
			URLQueryItem(name: "query", value: query),
			URLQueryItem(name: "page", value: page.description),
		]
		return .init(path: .personSearch, httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}

	
	// Movie
	
	static fileprivate func movieDetails(id: Int) -> SimpleHTTPJSONServiceTask<Movie> {
		return .init(path: .movieDetails.addingPath("\(id)"), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func movieRecommendations(id: Int, page: Int) -> SimpleHTTPJSONServiceTask<MovieSearchResults> {
		let query = [
			URLQueryItem(name: "page", value: page.description),
		]

		return .init(path: .movieRecommendations.substituting(values: ["id": id]), httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func movieCredits(id: Int) -> SimpleHTTPJSONServiceTask<Credits> {
		return .init(path: .movieCredits.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func movieWhereToWatch(id: Int) -> SimpleHTTPJSONServiceTask<WhereToWatchSearch> {
		return .init(path: .movieWhereToWatch.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}

	
	// TV
	
	static fileprivate func tvDetails(id: Int) -> SimpleHTTPJSONServiceTask<TV> {
		return .init(path: .tvDetails.addingPath("\(id)"), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}

	static fileprivate func tvRecommendations(id: Int, page: Int) -> SimpleHTTPJSONServiceTask<TVSearchResults> {
		let query = [
			URLQueryItem(name: "page", value: page.description),
		]

		return .init(path: .tvRecommendations.substituting(values: ["id": id]), httpMethod: .get(query), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func tvCredits(id: Int) -> SimpleHTTPJSONServiceTask<Credits> {
		return .init(path: .tvCredits.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func tvWhereToWatch(id: Int) -> SimpleHTTPJSONServiceTask<WhereToWatchSearch> {
		return .init(path: .tvWhereToWatch.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	
	// People
	
	static fileprivate func peopleDetails(id: Int) -> SimpleHTTPJSONServiceTask<Person> {
		return .init(path: .peopleDetails.addingPath("\(id)"), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func peopleMovieCredits(id: Int) -> SimpleHTTPJSONServiceTask<PersonCredits> {
		return .init(path: .peopleMovieCredits.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func peopleTVCredits(id: Int) -> SimpleHTTPJSONServiceTask<PersonCredits> {
		return .init(path: .peopleTVCredits.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
	
	static fileprivate func peopleCombinedCredits(id: Int) -> SimpleHTTPJSONServiceTask<PersonCredits> {
		return .init(path: .peopleCombinedCredits.substituting(values: ["id": id]), httpMethod: .get(), jsonDecoder: MovieDBConstnts.movieDBJSONDecoder)
	}
}
