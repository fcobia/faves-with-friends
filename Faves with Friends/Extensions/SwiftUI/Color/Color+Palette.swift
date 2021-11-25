//
//  Color+Palette.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


extension Color {

	struct Palette {
		let name: String

		var mainBackground: Color {
			Color(fromPalette: self.name, semanticName: "background-main")
		}

		var midBackground: Color {
			Color(fromPalette: self.name, semanticName: "background-mid")
		}

		var alternativeBackground: Color {
			Color(fromPalette: self.name, semanticName: "background-alt")
		}

		var primaryText: Color {
			Color(fromPalette: self.name, semanticName: "text-primary")
		}

		var alternativeText: Color {
			Color(fromPalette: self.name, semanticName: "text-alt")
		}

		var primary: Color {
			Color(fromPalette: self.name, semanticName: "primary")
		}

		var secondary: Color {
			Color(fromPalette: self.name, semanticName: "secondary")
		}

		var tertiary: Color {
			Color(fromPalette: self.name, semanticName: "tertiary")
		}

		var quaternary: Color {
			Color(fromPalette: self.name, semanticName: "quaternary")
		}
	}
}


private extension Color {

	init(fromPalette palette: String, semanticName: String) {
		#if os(macOS)
			self.init(NSColor(named: "\(palette)/\(semanticName)")!)
		#else
			self.init(UIColor(named: "\(palette)/\(semanticName)")!)
		#endif
	}

}
