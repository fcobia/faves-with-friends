//
//  TVEpisode.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 3/16/22.
//

import Foundation


struct TVEpisode: Codable {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case episodeNumber		= "episode_number"
		case seasonNumber		= "season_number"
		case airDate			= "air_date"
		case name
		case overview
		case crew
		case guestStars			= "guest_stars"
	}
	
	
	// MARK: JSON
	let id: Int
	let episodeNumber: Int
	let seasonNumber: Int
	let airDate: Date?
	let name: String?
	let overview: String?
	let crew: [MovieCrewCreditEntry]
	let guestStars: [MovieCastCreditEntry]
}
