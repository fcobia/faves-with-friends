//
//  MovieSearch.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation


struct MovieSearch: Decodable, MovieCommon, SearchResult {	
    
    // MARK: CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPathString    	= "poster_path"
		case backdropPathString		= "backdrop_path"
        case releaseDate 			= "release_date"
		case overview
    }
    
    
    // MARK: JSON Variables
    let id: Int
	let title: String
	let posterPathString: String?
	let backdropPathString: String?
	let releaseDate: Date?
	let overview: String?

	
	// MARK: SearchResult Computed Variables
	var type: SearchResultType {
		.movie
	}
	
	var name: String {
		title
	}
	
	var image: URL? {
		posterPath
	}
	
	var date: Date? {
		releaseDate
	}
	
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(Int.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		posterPathString = try container.decodeIfPresent(String.self, forKey: .posterPathString)
		backdropPathString = try container.decodeIfPresent(String.self, forKey: .backdropPathString)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)

		// Found a movie with an empty string for a date
		do {
			releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)
		}
		catch let error {
			if try container.decodeIfPresent(String.self, forKey: .releaseDate) == "" {
				releaseDate = nil
			}
			else {
				throw error
			}
		}
	}
}
