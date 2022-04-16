//
//  TVCommon.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


protocol TVCommon: Video {
	
	// MARK: JSON Variables
	var name: String { get }
	var firstAirDate: Date? { get }
}


extension TVCommon {
	
	var type: VideoType {
		.tv
	}
}
