//
//  PersonCrewCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation



struct PersonCrewCreditEntry: Codable, CrewCreditEntry {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case job
		case posterPathString	= "poster_path"
	}
	
	
	// MARK: JSON
	let id: Int
	let title: String?
	let job: String?
	let posterPathString: String?
}


// MARK: - Default Implementation
extension PersonCrewCreditEntry {
	
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
}


// MARK: - CrewCreditEntry Implementation
extension PersonCrewCreditEntry {
	
	var name: String? { title }
	var image: URL? { posterPath }
}
