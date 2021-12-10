//
//  MultiSearchResults.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/26/21.
//

import Foundation


struct MultiSearchResults: MovieDBSearchResults {

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
		let intermediates: [Intermediate] = try container.decodeIfPresent([Intermediate].self, forKey: .results) ?? []
		self.results = intermediates.map({ $0.value })
	}
}



private struct Intermediate: Decodable {

	private enum CodingKeys: String, CodingKey {
		case mediaType	= "media_type"
	}

	let value: SearchResult

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let mediaType = try container.decode(String.self, forKey: .mediaType)
		switch mediaType {
				
			case "movie":
				value = try MovieSearch(from: decoder)
				
			case "tv":
				value = try TVSearch(from: decoder)
				
			case "person":
				value = try PersonSearch(from: decoder)
				
			default:
				throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown search result type: \(mediaType)", underlyingError: nil))
		}
	}
}
