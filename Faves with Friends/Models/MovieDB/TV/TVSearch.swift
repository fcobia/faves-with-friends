//
//  TVSearch.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


struct TVSearch: TVCommon, SearchResult {
	
	// MARK: Coding Keys
	private enum CodingKeys: String, CodingKey {
		case id
		case posterPathString	= "poster_path"
		case overview
		case name
		case firstAirDate		= "first_air_date"
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let posterPathString: String?
	let overview: String?
	let name: String
	let firstAirDate: Date?

	
	// MARK: Computed Variables
	var title: String {
		name
	}
	
	var releaseDate: Date? {
		return firstAirDate
	}

	
	// MARK: SearchResult Computed Variables
	var type: SearchResultType {
		.tv
	}
	
	var image: URL? {
		posterPath
	}
	
	var date: Date? {
		firstAirDate
	}
}
