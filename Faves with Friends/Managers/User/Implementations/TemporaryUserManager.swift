//
//  TemporaryUserManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation
import Combine


final class TemporaryUserManager: UserManager {
	
	// MARK: Constants
	private enum Constants {
		static let user = User(email: "frank_cobia@me.com")
	}
	
	
	// MARK: Private Variables
	private let userSubject: CurrentValueSubject<User?,Never> = .init(nil)

	
	// MARK: UserManager Variables
	var userPublisher: AnyPublisher<User?,Never> {
		return userSubject.eraseToAnyPublisher()
	}
	
	var networkToken: CustomStringConvertible? {
		get async throws {
			return Bundle.main.object(forInfoDictionaryKey: "THE_MOVIE_DB_API_KEY") as! String
		}
	}
	
	var hasUserCredentials: Bool {
		get async throws {
			return true
		}
	}
	
	private(set) var user: User? = nil {
		didSet {
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				
				self.userSubject.send(self.user)
			}
		}
	}
	
	
	// MARK: Init
	init(loggedIn: Bool = false) {
		if loggedIn {
			self.user = Constants.user
			self.userSubject.send(user)
		}
	}
	
	
	// MARK: Public Methods
	func login() async throws -> User {
		guard let user = user else {
			throw LocalErrors.noUser
		}
		
		return user
	}
	
	func login(username: String, password: String, remember: Bool) async throws -> User {
		let result = Constants.user
		
		self.user = result
		
		return result
	}
	
	func logout() async throws {
		self.user = nil
	}
}


private enum LocalErrors: Error {
	case noUser
}
