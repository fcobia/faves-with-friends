//
//  Video.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


protocol Video: Identifiable {
	
	// MARK: JSON Variables
	var id: Int{ get }
	var title: String { get }
	var posterPathString: String? { get }
	var overview: String? { get }
	var releaseDate: Date? { get }

	// MARK: Computed Variables
	var posterPath: URL? { get }
}


extension Video {
	
	var posterPath: URL? {
		guard let posterPathString = posterPathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(posterPathString)")
	}
}
