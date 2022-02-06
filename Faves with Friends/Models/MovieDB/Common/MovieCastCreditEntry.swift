//
//  MovieCastCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


struct MovieCastCreditEntry: Codable, CastCreditEntry {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case character
		case profilePathString	= "profile_path"
	}
	
	
	// MARK: JSON
	let id: Int
	let name: String?
	let character: String?
	let profilePathString: String?
}


// MARK: - Default Implementation
extension MovieCastCreditEntry {
	
	var profilePath: URL? {
		guard let profilePathString = profilePathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(profilePathString)")
	}
}


// MARK: - CrewCreditEntry Implementation
extension MovieCastCreditEntry {
	
	var image: URL? { profilePath }
}
