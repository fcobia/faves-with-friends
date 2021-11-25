//
//  UserManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import Foundation
import Combine


protocol UserManager {
	
	// MARK: Variables
	var userPublisher: AnyPublisher<User?,Never> { get }
	var networkToken: CustomStringConvertible? { get async throws }
	var hasUserCredentials: Bool { get async throws }
	var user: User? { get }
	
	
	// MARK: Public Methods
	func login() async throws -> User
	func login(username: String, password: String, remember: Bool) async throws -> User
	func logout() async throws
}
