//
//  TVSeason.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 3/16/22.
//

import Foundation


struct TVSeason: Codable {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case seasonNumber		= "season_number"
		case airDate			= "air_date"
		case name
		case overview
		case posterPathString	= "poster_path"
		case episodes
	}
	
	
	// MARK: JSON
	let id: Int
	let seasonNumber: Int
	let airDate: Date?
	let name: String?
	let overview: String?
	let posterPathString: String?
	let episodes: [TVEpisode]
}


// MARK: - Default Implementation
extension TVSeason {
	
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
}
