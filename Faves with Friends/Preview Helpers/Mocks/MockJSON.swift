//
//  MockJSON.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/2/22.
//

import Foundation

#if DEBUG
protocol MockJSON {
	associatedtype JSONType: Decodable
	
	static var json: String { get }
	
	static func parsed() -> JSONType
}


extension MockJSON {
	
	static func parsed() -> JSONType {
		try! MovieDBConstnts.movieDBJSONDecoder.decode(JSONType.self, from: Self.json.data(using: .utf8)!)
	}
}
#endif
