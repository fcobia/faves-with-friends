//
//  Movie.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


struct Movie: Decodable {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case title
        case poster_path
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let title: String
    let poster_path: String
}
