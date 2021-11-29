//
//  MovieSearchResult.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/26/21.
//

import Foundation


struct MovieSearchResult: Decodable {

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
    let results: [MovieSearchResultObject]?
}
