//
//  MovieNetworkErrorResponse.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation


enum MovieNetworkErrorResponse: Error {
	case info(MovieNetworkErrorInfo)
}


extension MovieNetworkErrorResponse: Decodable {
	
	init(from decoder: Decoder) throws {
		let info = try MovieNetworkErrorInfo(from: decoder)
		
		self = .info(info)
	}
}
