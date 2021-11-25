//
//  Environment+EnvironmentManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI
import Combine


private struct EnvironmentManagerKey: EnvironmentKey {
	static let defaultValue: EnvironmentManager = DummyEnvironmentManager()
}

extension EnvironmentValues {
	var environmentManager: EnvironmentManager {
		get {
			return self[EnvironmentManagerKey.self]
		}
		set {
			self[EnvironmentManagerKey.self] = newValue
		}
	}
}



// MARK: - DefaultValue
private struct DummyEnvironmentManager: EnvironmentManager {
	var movieNetworkManager: MovieNetworkManager {
		fatalError("This is not meant to be used")
	}
	var userManager: UserManager {
		fatalError("This is not meant to be used")
	}
}
