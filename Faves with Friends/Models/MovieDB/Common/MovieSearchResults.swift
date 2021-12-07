//
//  MovieSearchResults.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/7/21.
//

import Foundation


struct MovieSearchResults: MovieDBSearchResults {

	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case page
		case totalPages		= "total_pages"
		case totalResults	= "total_results"
		case results
	}
	
	
	// MARK: JSON Variables
	let page: Int
	let totalPages: Int
	let totalResults: Int
	let results: [SearchResult]
	
	
	// MARK: Decodable
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		page = try container.decode(Int.self, forKey: .page)
		totalPages = try container.decode(Int.self, forKey: .totalPages)
		totalResults = try container.decode(Int.self, forKey: .totalResults)
		
		// Loop through the results
		self.results = try container.decodeIfPresent([MovieSearch].self, forKey: .results) ?? []
	}
}
