//
//  SecondaryButtonModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct SecondaryButtonModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
			.buttonStyle(SecondaryButtonStyle())
	}
}


// MARK: - TextField Extension
extension Button {
	
	func appSecondaryButton() -> ModifiedContent<Button, SecondaryButtonModifier> {
		return self.modifier(SecondaryButtonModifier())
	}
}


// MARK: - Button Style
private struct SecondaryButtonStyle: ButtonStyle {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ButtonStyle
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(maxWidth: .infinity)
			.padding(8)
			.font(.body)
			.foregroundColor(palettes.color.primary)
			.overlay(Capsule().stroke(palettes.color.primary, lineWidth: 2))
			.opacity(configuration.isPressed ? 0.5 : 1)
	}
}


// MARK: - Preview
struct SecondaryButtonModifier_Previews: PreviewProvider {
	static var previews: some View {
		Group {

			Button("Button", action: {})
				.appSecondaryButton()
				.preferredColorScheme(.light)

			Button("Button", action: {})
				.appSecondaryButton()
				.preferredColorScheme(.dark)
		}
		.frame(width: 200)
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
