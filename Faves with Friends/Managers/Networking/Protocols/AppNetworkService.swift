//
//  AppNetworkService.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation
import HTTPServiceCore


protocol AppNetworkService {
	
	func fetch<ResultType>(_ task: SimpleHTTPJSONServiceTask<ResultType>) async throws -> ResultType
}
