//
//  MovieDBSearchResults.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/26/21.
//

import Foundation


protocol MovieDBSearchResults: Decodable {
	
	// MARK: JSON Variables
	var page: Int { get }
	var totalPages: Int { get }
	var totalResults: Int { get }
	var results: [SearchResult] { get }
}
