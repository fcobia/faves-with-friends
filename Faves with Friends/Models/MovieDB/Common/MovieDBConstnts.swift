//
//  MovieDBConstnts.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/9/21.
//

import Foundation


enum MovieDBConstnts {
	
	@inlinable
	static var movieDBJSONDecoder: JSONDecoder {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(df)
		
		return decoder
	}

}
