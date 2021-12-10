//
//  MovieNetworkManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation
import HTTPServiceCore
import HTTPServiceFoundation


protocol MovieNetworkManager {

	func movieDetails(id: Int) async throws -> Movie
    func search(query: String, type: SearchType) async throws -> MovieDBSearchResults
}
