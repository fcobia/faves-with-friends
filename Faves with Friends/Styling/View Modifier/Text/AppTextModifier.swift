//
//  AppTextModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct AppTextModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
			.font(.body)
			.foregroundColor(palettes.color.primaryText)
	}
}


// MARK: - TextField Extension
extension Text {
	
	func appText() -> ModifiedContent<Text, AppTextModifier> {
		return self.modifier(AppTextModifier())
	}
}


// MARK: - Preview
struct AppTextModifier_Previews: PreviewProvider {
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
