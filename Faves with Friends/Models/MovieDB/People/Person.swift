//
//  Person.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


struct Person: Codable, PersonCommon {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case profilePathString	= "profile_path"
		case birthday
		case deathday
		case biography
	}
	
	
	// MARK: JSON Variables
	let id: Int
	let name: String
	let profilePathString: String?
	let birthday: Date?
	let deathday: Date?
	let biography: String?
}
