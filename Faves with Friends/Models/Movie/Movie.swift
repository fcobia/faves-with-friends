//
//  Movie.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


struct Movie: Decodable, Identifiable, MovieCommon {
	
    struct Genre: Decodable, Identifiable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
        }
        
        let id: Int
        let name: String
    }
    
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
        case genres
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
    let genres: [Genre]
	
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
    
    static let movieExample = Movie(id: 550, title: "Fight Club", posterPathString: "", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", releaseDate: "1999-10-12", runtime: 139, status: "Released", backdropPathString: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", genres: [Genre(id: 18, name: "Drama"), Genre(id: 17, name: "Action")])
}
