//
//  PersonCredits.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


struct PersonCredits: Decodable {
	
	let cast: [PersonCastCreditEntry]
	let crew: [PersonCrewCreditEntry]
}
