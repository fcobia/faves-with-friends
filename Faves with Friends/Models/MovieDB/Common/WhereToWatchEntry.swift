//
//  WhereToWatchEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/29/22.
//

import Foundation


struct WhereToWatchEntry {
	
	// MARK: JSON Variables
	let displayPriority: Int
	let logoPathString: String
	let providerId: Int
	let providerName: String
}


extension WhereToWatchEntry {
	
	var logoPath: URL? {
		return URL(string: "https://image.tmdb.org/t/p/original\(logoPathString)")
	}
}


extension WhereToWatchEntry: Decodable {
	
	enum CodingKeys: String, CodingKey {
		case displayPriority	= "display_priority"
		case logoPathString		= "logo_path"
		case providerId			= "provider_id"
		case providerName		= "provider_name"
	}
}
