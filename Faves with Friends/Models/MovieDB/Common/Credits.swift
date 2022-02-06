//
//  Credits.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/26/22.
//

import Foundation


struct Credits: Decodable {
	let cast: [MovieCastCreditEntry]
	let crew: [MovieCrewCreditEntry]
}
