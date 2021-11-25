//
//  MovieHTTPServiceErrorMapper.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation
import HTTPServiceCore


struct MovieHTTPServiceErrorMapper: HTTPServiceErrorMapper {
	
	func mapError(_ error: Error, task: HTTPServiceTask) -> Error {
		
		// We only map one kind of error
		if case HTTPServiceError.httpError(let data, _) = error, let data = data {
			
			// Try to map it as an Error Response
			do {
				let errorResponse = try JSONDecoder().decode(MovieNetworkErrorResponse.self, from: data)
				
				return errorResponse
			}
			catch {
				// Do nothing
			}
		}
		
		// Return the original error
		return error
	}
}
