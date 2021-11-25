//
//  AppSecureFieldModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct AppSecureFieldModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
		//			.textFieldStyle(.roundedBorder)
					.padding(8)
//					.overlay(RoundedRectangle(cornerRadius: 10).stroke(palettes.color.tertiary, lineWidth: 1))
					.overlay(Rectangle().stroke(palettes.color.tertiary, lineWidth: 1))
	}
}


// MARK: - TextField Extension
extension SecureField {
	
	func appSecureField() -> ModifiedContent<SecureField<Label>, AppSecureFieldModifier> {
		return self.modifier(AppSecureFieldModifier())
	}
}


// MARK: - Preview
struct AppSecureFieldModifier_Previews: PreviewProvider {
	@State static var text: String = ""
	
	static var previews: some View {
		Group {
			SecureField("Password", text: $text)
				.appSecureField()
				.preferredColorScheme(.light)

			SecureField("Password", text: $text)
				.appSecureField()
			.preferredColorScheme(.dark)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
