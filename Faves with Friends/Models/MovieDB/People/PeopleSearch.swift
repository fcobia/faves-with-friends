//
//  PeopleSearch.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


struct PeopleSearch: PeopleCommon, SearchResult {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case profilePathString	= "profile_path"
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let name: String
	let profilePathString: String?


	// MARK: SearchResult Computed Variables
	var type: SearchResultType {
		.people
	}
	
	var image: URL? {
		profilePath
	}
	
	var date: Date? {
		return nil
	}
}
