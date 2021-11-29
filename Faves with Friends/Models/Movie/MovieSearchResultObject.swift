//
//  MovieSearchResultObject.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation

struct MovieSearchResultObject: Decodable, Identifiable, MovieCommon {
    
    // MARK: CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPathString    = "poster_path"
        case releaseDate = "release_date"
    }
    
    
    // MARK: JSON Variables
    var id: Int
    var title: String
    var posterPathString: String?
    var releaseDate: String
    
    // MARK: Public Computed Variables
    var posterPath: URL? {
        guard let posterPathString = posterPathString else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
    }
}
