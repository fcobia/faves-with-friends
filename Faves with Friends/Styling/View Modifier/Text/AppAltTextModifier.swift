//
//  AppAltTextModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/2/21.
//

import SwiftUI


struct AppAltTextModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
			.font(.body)
			.foregroundColor(palettes.color.alternativeText)
	}
}


// MARK: - TextField Extension
extension Text {
	
	func appAltText() -> ModifiedContent<Text, AppAltTextModifier> {
		return self.modifier(AppAltTextModifier())
	}
}


// MARK: - Preview
struct AppAltTextModifier_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Text("Title")
				.appText()
				.preferredColorScheme(.light)

			Text("Title")
				.appText()
			.preferredColorScheme(.dark)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
