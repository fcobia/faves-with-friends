//
//  MovieNetworkErrorInfo.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation


struct MovieNetworkErrorInfo {
	
	// MARK: JSON Variables
	let code: Int
	let developerMessage: String?
	let title: String?
	let message: String?
	let buttons: [DisplayableErrorInfoButton]?
}


extension MovieNetworkErrorInfo: Decodable {
	
	// MARK: CodingKeys
	private enum CodingKeys: String, CodingKey {
		case code 				= "status_code"
		case developerMessage	= "status_message"
	}
	
	
	// MARK: Decodable Init
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		code = try container.decode(Int.self, forKey: .code)
		developerMessage = try container.decodeIfPresent(String.self, forKey: .developerMessage)
		title = nil
		message = nil
		buttons = nil
	}
}
