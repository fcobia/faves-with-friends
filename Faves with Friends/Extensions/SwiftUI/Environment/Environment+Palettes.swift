//
//  Environment+Palettes.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


private struct PalettesKey: EnvironmentKey {
	static let defaultValue = Palettes.standard
}

extension EnvironmentValues {
	var preferredPalettes: Palettes {
		get {
			return self[PalettesKey.self]
		}
		set {
			self[PalettesKey.self] = newValue
		}
	}
}
