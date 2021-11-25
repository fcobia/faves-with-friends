//
//  MovieHTTPServiceNetworkConnector.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation
import Combine
import HTTPServiceCore
import HTTPServiceFoundation


final class MovieHTTPServiceNetworkConnector: FoundationHTTPServiceNetworkConnector {
	
	// MARK: Variables
	private let userManager: UserManager
	
	
	// MARK: Init
	
	init(userManager: UserManager) {
		self.userManager = userManager
	}
	
	
	// MARK: FoundationHTTPServiceNetworkConnector Functions
	
	override func modifyRequest(_ request: RequestType, fromTask: HTTPServiceTask) async throws -> RequestType {
		
		if try await userManager.hasUserCredentials {
			if let networkToken = try await userManager.networkToken {
				var newRequest = request
				
				newRequest.addValue("Bearer \(networkToken.description)", forHTTPHeaderField: "Authorization")
				
				return newRequest
			}
		}

		return request
	}
	
	// Ignore: This just calls the async version
	override func modifyRequest(_ request: RequestType, fromTask task: HTTPServiceTask) -> AnyPublisher<RequestType, Error> {
		return Just(request)
			.flatMap { request in
				return Future { promise in
					Task.detached {
						
						do {
							let newRequest = try await self.modifyRequest(request, fromTask: task)
							
							promise(.success(newRequest))
						}
						catch let error {
							promise(.failure(error))
						}
					}
				}
			}
			.eraseToAnyPublisher()
	}

	// Ignore: This just calls the async version
	override func modifyRequest(_ request: RequestType, fromTask task : HTTPServiceTask, completion: @escaping (Result<RequestType, Error>) -> Void) {
		Task.detached {
			
			do {
				let newRequest = try await self.modifyRequest(request, fromTask: task)
				
				completion(.success(newRequest))
			}
			catch let error {
				completion(.failure(error))
			}
		}
	}
}
