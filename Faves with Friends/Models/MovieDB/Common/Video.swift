//
//  Video.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


protocol Video: Equatable {
	
	// MARK: JSON Variables
	var id: Int{ get }
	var title: String { get }
	var posterPathString: String? { get }
	var backdropPathString: String? { get }
	var overview: String? { get }
	var releaseDate: Date? { get }
	var type: VideoType { get }

	// MARK: Computed Variables
	var posterPath: URL? { get }
	var backdropPath: URL? { get }
}


extension Video {
	
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


extension Video {
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.id == rhs.id && lhs.type == rhs.type
	}
}
