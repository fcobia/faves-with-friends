//
//  Environment+User.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


private struct UserKey: EnvironmentKey {
	static let defaultValue: User = User(email: "test@test.com")
}

extension EnvironmentValues {
	var user: User {
		get {
			return self[UserKey.self]
		}
		set {
			self[UserKey.self] = newValue
		}
	}
}
