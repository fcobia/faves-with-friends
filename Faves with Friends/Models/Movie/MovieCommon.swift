//
//  MovieCommon.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation

protocol MovieCommon {
	
    // MARK: JSON Variables
    var id: Int{ get }
    var title: String { get }
    var posterPathString: String? { get }
	var backdropPathString: String? { get }
    var releaseDate: Date? { get }
	
	var posterPath: URL? { get }
	var backdropPath: URL? { get }
}


extension MovieCommon {
	
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
 
