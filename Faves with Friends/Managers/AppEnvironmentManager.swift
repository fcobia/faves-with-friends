//
//  AppEnvironmentManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


class AppEnvironmentManager: EnvironmentManager {
	
	// MARK: Public Variables
	let userManager: UserManager
	let movieNetworkManager: MovieNetworkManager

	
	// MARK: Init
	
	init(userManager: UserManager, movieNetworkManager: MovieNetworkManager) {
		self.userManager = userManager
		self.movieNetworkManager = movieNetworkManager
	}
}


// MARK: - Default Instance
extension AppEnvironmentManager {
	
	static func createDefault() -> EnvironmentManager {
		let userManager = TemporaryUserManager()
		let movieNetworkService = MovieHTTPService(url: URL(string: "https://api.themoviedb.org")!, userManager: userManager, retryCount: 0)
		let movieNetworkManager = MovieNetworkManager(movieNetworkService: movieNetworkService)
		
		return AppEnvironmentManager(userManager: userManager, movieNetworkManager: movieNetworkManager)
	}
}
