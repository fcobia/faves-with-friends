//
//  Movie.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


struct Movie: Decodable, Identifiable {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
        case posterPathString	= "poster_path"
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let title: String
    let posterPathString: String?
	
	// MARK: Public Computed Variables
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
}
