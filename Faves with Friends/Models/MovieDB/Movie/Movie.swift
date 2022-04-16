//
//  Movie.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


struct Movie: Codable, MovieCommon {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
        case posterPathString	= "poster_path"
        case overview
        case releaseDate 		= "release_date"
        case runtime
        case status
        case backdropPathString	= "backdrop_path"
        case genres
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let title: String
	let posterPathString: String?
	let backdropPathString: String?
	let releaseDate: Date?
	let overview: String?
    let runtime: Int?
    let status: String
    let genres: [Genre]
    
	
	// MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(posterPathString, forKey: .posterPathString)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(runtime, forKey: .runtime)
        try container.encode(status, forKey: .status)
        try container.encode(backdropPathString, forKey: .backdropPathString)
        try container.encode(genres, forKey: .genres)
    }
}


//#if DEBUG
extension Movie {
	
	private static var df: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		
		return df
	}()
	
	static let movieExample = Movie(id: 550, title: "Fight Club", posterPathString: nil, backdropPathString: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", releaseDate: df.date(from: "1999-10-12")!, overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", runtime: 139, status: "Released", genres: [Genre(id: 18, name: "Drama"), Genre(id: 17, name: "Action")])
}
//#endif
