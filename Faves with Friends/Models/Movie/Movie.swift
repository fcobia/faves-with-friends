//
//  Movie.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


struct Movie: Decodable, Identifiable, MovieCommon {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
        case posterPathString	= "poster_path"
        case overview
        case releaseDate = "release_date"
        case runtime
        case status
        case backdropPathString = "backdrop_path"
	}
	
	
	// MARK: JSON Variables
	var id: Int
	var title: String
    var posterPathString: String?
    let overview: String
    var releaseDate: String
    let runtime: Int
    let status: String
    let backdropPathString: String?
	
	// MARK: Public Computed Variables
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
    
    var backdropPath: URL? {
        guard let backdropPathString = backdropPathString else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPathString)")
    }
}
