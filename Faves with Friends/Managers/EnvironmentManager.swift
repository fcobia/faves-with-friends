//
//  EnvironmentManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


protocol EnvironmentManager {
	var userManager: UserManager { get }
	var movieNetworkManager: MovieNetworkManager { get }
}
