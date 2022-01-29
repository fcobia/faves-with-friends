//
//  WhereToWatch.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/29/22.
//

import Foundation


struct WhereToWatch: Decodable {
	
	// MARK: JSON Variables
	let link: URL
	let flatRate: [WhereToWatchEntry]?
	let rent: [WhereToWatchEntry]?
	let buy: [WhereToWatchEntry]?
}


struct WhereToWatchSearch: Decodable {
	
	private enum CodingKeys: CodingKey {
		case results
	}
	
	
	let result: WhereToWatch?
	
	
	init(from decoder: Decoder) throws {
		var result: WhereToWatch? = nil
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let resultsContiner = try container.nestedContainer(keyedBy: JSONDynamicKey.self, forKey: .results)
		
		if let countryCode = Locale.current.regionCode?.uppercased() {
			if resultsContiner.allKeys.contains(where: { $0.stringValue == countryCode }) {
				result = try resultsContiner.decode(WhereToWatch.self, forKey: JSONDynamicKey(stringValue: countryCode)!)
			}
		}
		
		self.result = result
	}
}
