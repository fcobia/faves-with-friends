//
//  TVSearch.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


struct TVSearch: TVCommon, SearchResult {
	
	
	// MARK: Coding Keys
	private enum CodingKeys: String, CodingKey {
		case id
		case posterPathString	= "poster_path"
		case backdropPathString	= "backdrop_path"
		case overview
		case name
		case firstAirDate		= "first_air_date"
        case popularity
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let posterPathString: String?
	let backdropPathString: String?
	let overview: String?
	let name: String
	let firstAirDate: Date?
    let popularity: Double?
	
	// MARK: Computed Variables
	var title: String {
		name
	}
	
	var releaseDate: Date? {
		return firstAirDate
	}

	
	// MARK: SearchResult Computed Variables
	var type: SearchResultType {
		.tv
	}
	
	var image: URL? {
		posterPath
	}
	
	var date: Date? {
		firstAirDate
	}
	
	
	// MARK: Decoder
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		posterPathString = try container.decodeIfPresent(String.self, forKey: .posterPathString)
		backdropPathString = try container.decodeIfPresent(String.self, forKey: .backdropPathString)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)

		// Found a movie with an empty string for a date
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
	}
}
