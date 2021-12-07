//
//  MovieCommon.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation

protocol MovieCommon: Video {
	
    // MARK: JSON Variables
	var backdropPathString: String? { get }
	
	var posterPath: URL? { get }
	var backdropPath: URL? { get }
}


extension MovieCommon {
	
	var backdropPath: URL? {
		guard let backdropPathString = backdropPathString else {
			return nil
		}
		return URL(string: "https://image.tmdb.org/t/p/original\(backdropPathString)")
	}
}
 
