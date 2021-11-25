//
//  Palettes.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct Palettes {
	
	// MARK: Variables
	let color: Color.Palette
	
	
	// MARK: Init
	
	init(color: Color.Palette) {
		self.color = color
	}
}


extension Palettes {
	
	static var standard: Palettes {
		return Palettes(color: Color.Palette.standard)
	}
}
