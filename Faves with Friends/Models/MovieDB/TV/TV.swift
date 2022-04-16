//
//  TV.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/1/22.
//

import Foundation


struct TV: Codable, TVCommon {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case backdropPathString	= "backdrop_path"
		case posterPathString	= "poster_path"
		case name
		case createdBy			= "created_by"
		case episodeRunTime		= "episode_run_time"
		case firstAirDate		= "first_air_date"
		case lastAirDate		= "last_air_date"
		case genres
		case homepageString		= "homepage"
		case inProduction		= "in_production"
		case numberOfEpisodes	= "number_of_episodes"
		case numberOfSeasons	= "number_of_seasons"
		case overview
		case popularity
	}
	
	// MARK: JSON Variables
	let id: Int
	let posterPathString: String?
	let backdropPathString: String?
	let name: String
	let createdBy: [TVPerson]?
	let episodeRunTime: [Int]
	let firstAirDate: Date?
	let lastAirDate: Date?
	let genres: [Genre]
	let inProduction: Bool
	let numberOfEpisodes: Int
	let numberOfSeasons: Int
	let overview: String?
	let popularity: Double
	
	// MARK: Computed Variables
	var title: String {
		name
	}
	
	var releaseDate: Date? {
		firstAirDate
	}
	
	var homepage: URL? {
		guard let homepageString = homepageString, let url = URL(string: homepageString) else { return nil }
		
		return url
	}
	
	// MARK: Private Variables
	private let homepageString: String?
	
	
	// MARK: Decoder
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		homepageString = try container.decodeIfPresent(String.self, forKey: .homepageString)

		id = try container.decode(Int.self, forKey: .id)
		posterPathString = try container.decodeIfPresent(String.self, forKey: .posterPathString)
		backdropPathString = try container.decodeIfPresent(String.self, forKey: .backdropPathString)
		name = try container.decode(String.self, forKey: .name)
		createdBy = try container.decodeIfPresent([TVPerson].self, forKey: .createdBy)
		episodeRunTime = try container.decode([Int].self, forKey: .episodeRunTime)
		genres = try container.decode([Genre].self, forKey: .genres)
		inProduction = try container.decode(Bool.self, forKey: .inProduction)
		numberOfEpisodes = try container.decode(Int.self, forKey: .numberOfEpisodes)
		numberOfSeasons = try container.decode(Int.self, forKey: .numberOfSeasons)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
		popularity = try container.decode(Double.self, forKey: .popularity)

		// Found a date with an empty string
		do {
			firstAirDate = try container.decodeIfPresent(Date.self, forKey: .firstAirDate)
		}
		catch let error {
			if try container.decodeIfPresent(String.self, forKey: .firstAirDate) == "" {
				firstAirDate = nil
			}
			else {
				throw error
			}
		}
		do {
			lastAirDate = try container.decodeIfPresent(Date.self, forKey: .lastAirDate)
		}
		catch let error {
			if try container.decodeIfPresent(String.self, forKey: .lastAirDate) == "" {
				lastAirDate = nil
			}
			else {
				throw error
			}
		}
	}
}


// MARK: - TVPerson
struct TVPerson: Codable, PersonCommon {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case creditId = "credit_id"
		case name
		case gender
		case profilePathString	= "profile_path"
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let creditId: String
	let name: String
	let gender: Gender
	let profilePathString: String?
}


// MARK:
