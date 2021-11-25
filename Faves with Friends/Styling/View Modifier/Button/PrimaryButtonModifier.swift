//
//  PrimaryButtonModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct PrimaryButtonModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
			.buttonStyle(PrimaryButtonStyle())
	}
}


// MARK: - TextField Extension
extension Button {
	
	func appPrimaryButton() -> ModifiedContent<Button, PrimaryButtonModifier> {
		return self.modifier(PrimaryButtonModifier())
	}
}


// MARK: - Button Style
private struct PrimaryButtonStyle: ButtonStyle {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ButtonStyle
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(maxWidth: .infinity)
			.padding(8)
			.font(.body)
			.foregroundColor(palettes.color.alternativeText)
			.background(palettes.color.primary, in: Capsule())
			.opacity(configuration.isPressed ? 0.5 : 1)
	}
}


// MARK: - Preview
struct PrimaryButtonModifier_Previews: PreviewProvider {
	static var previews: some View {
		Group {

			Button("Button", action: {})
				.appPrimaryButton()
				.preferredColorScheme(.light)

			Button("Button", action: {})
				.appPrimaryButton()
				.preferredColorScheme(.dark)
		}
		.frame(width: 200)
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
