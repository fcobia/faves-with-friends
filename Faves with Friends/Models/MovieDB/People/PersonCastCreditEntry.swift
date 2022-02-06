//
//  PersonCastCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


struct PersonCastCreditEntry: Codable, CastCreditEntry {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case character
		case posterPathString	= "poster_path"
	}
	
	
	// MARK: JSON
	let id: Int
	let title: String?
	let character: String?
	let posterPathString: String?
}


// MARK: - Default Implementation
extension PersonCastCreditEntry {
	
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
}


// MARK: - CrewCreditEntry Implementation
extension PersonCastCreditEntry {
	var name: String? { title }
	var image: URL? { posterPath }
}
