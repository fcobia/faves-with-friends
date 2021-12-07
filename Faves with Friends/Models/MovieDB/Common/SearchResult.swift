//
//  SearchResult.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/7/21.
//

import Foundation


protocol SearchResult: Decodable {
	
	// Variables
	var type: SearchResultType { get }
	var id: Int { get }
	var name: String { get }
	var image: URL? { get }
	var date: Date? { get }
}
