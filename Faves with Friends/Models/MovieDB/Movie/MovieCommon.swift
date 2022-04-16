//
//  MovieCommon.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/28/21.
//

import Foundation

protocol MovieCommon: Video {
}


extension MovieCommon {
	
	var type: VideoType {
		.movie
	}
}
