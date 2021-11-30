//
//  AppHTTPService.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation
import HTTPServiceCore
import HTTPServiceFoundation


struct MovieHTTPService: NetworkService {
	
	// MARK: - Private Variables
	private let userManager: UserManager
	private let retryCount: Int
	private let service: FoundationHTTPService<FoundationHTTPServiceNetworkConnector, FoundationHTTPCache>
	
	
	// MARK: Init
	
	init(url: URL, userManager: UserManager, retryCount: Int) {
		self.userManager = userManager
		self.retryCount = retryCount
		
		// Create the service
		let serviceConfig = SimpleHTTPServiceConfig(apiEndpoint: url)
		let networkAdaptor = FoundationHTTPServiceNetworkAdaptor()
		let serviceConnector = MovieHTTPServiceNetworkConnector(userManager: userManager)
		let errorMapper = MovieHTTPServiceErrorMapper()

		service = .init(config: serviceConfig, networkAdaptor: networkAdaptor, networkConnector: serviceConnector, errorMapper: errorMapper)
	}
	
	
	// MARK: - Private Methods
	
	private func fetch<ResultType>(_ task: SimpleHTTPJSONServiceTask<ResultType>, count: Int, allowLoginRetry: Bool) async throws -> ResultType {
		
		// Try the call
		do {
			return try await service.fetchJSON(task, forceFetch: true)
		}
		catch let error {
			
			// Is this a login error
			if allowLoginRetry, case MovieNetworkErrorResponse.info(let errorInfo) = error, errorInfo.code == MovieErrorCodes.invalidLogin {
				return try await tryLogin(task: task, count: count, originalError: error)
			}
			else if count < retryCount {	// Can we retry?
				return try await fetch(task, count: count + 1, allowLoginRetry: allowLoginRetry)
			}
			else {
				throw error
			}
		}
	}
	
	private func tryLogin<ResultType>(task: SimpleHTTPJSONServiceTask<ResultType>, count: Int, originalError: Error) async throws -> ResultType {
		
		// Do we have user credentials to try a login?
		let shouldAttemptLogin: Bool
		do {
			shouldAttemptLogin = try await userManager.hasUserCredentials
		}
		catch {
			shouldAttemptLogin = false
		}
		
		// Attemp a new login?
		if shouldAttemptLogin {
			
			// Attemp to login
			let _ = try await userManager.login()

			// Retry the attempt
			return try await fetch(task, count: count, allowLoginRetry: false)
		}
		else {
			throw originalError
		}
	}
	
	
	// MARK: - Public Methods
	
	func fetch<ResultType>(_ task: SimpleHTTPJSONServiceTask<ResultType>) async throws -> ResultType {
		return try await fetch(task, count: 0, allowLoginRetry: true)
	}
}
