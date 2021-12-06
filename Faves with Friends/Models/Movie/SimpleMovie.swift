//
//  MovieSearchResultObject.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation


struct SimpleMovie: Decodable, Identifiable, MovieCommon {	
    
    // MARK: CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPathString    	= "poster_path"
		case backdropPathString		= "backdrop_path"
        case releaseDate 			= "release_date"
    }
    
    
    // MARK: JSON Variables
    let id: Int
	let title: String
	let posterPathString: String?
	let backdropPathString: String?
	let releaseDate: Date?
}
