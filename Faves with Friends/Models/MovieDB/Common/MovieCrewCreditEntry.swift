//
//  MovieCrewCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


struct MovieCrewCreditEntry: Codable, CrewCreditEntry {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case job
		case profilePathString	= "profile_path"
	}
	
	
	// MARK: JSON
	let id: Int
	let name: String?
	let job: String?
	let profilePathString: String?
}


// MARK: - Default Implementation
extension MovieCrewCreditEntry {
	
	var profilePath: URL? {
		guard let profilePathString = profilePathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(profilePathString)")
	}
}


// MARK: - CrewCreditEntry Implementation
extension MovieCrewCreditEntry {
	
	var image: URL? { profilePath }
}
