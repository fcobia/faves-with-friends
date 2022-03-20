//
//  Environment+showModal.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 3/20/22.
//

import SwiftUI


private struct ShowModalKey: EnvironmentKey {
	static let defaultValue = Binding<Bool>.constant(false)
}

extension EnvironmentValues {
	var showModal: Binding<Bool> {
		get {
			return self[ShowModalKey.self]
		}
		set {
			self[ShowModalKey.self] = newValue
		}
	}
}
