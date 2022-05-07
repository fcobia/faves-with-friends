//
//  PersonSearch.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


struct PersonSearch: PersonCommon, SearchResult {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case profilePathString	= "profile_path"
        case popularity
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let name: String
	let profilePathString: String?
    let popularity: Double?


	// MARK: SearchResult Computed Variables
	var type: SearchResultType {
		.person
	}
	
	var image: URL? {
		profilePath
	}
	
	var date: Date? {
		return nil
	}
}
