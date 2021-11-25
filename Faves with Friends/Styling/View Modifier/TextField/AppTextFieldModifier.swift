//
//  AppTextFieldModifier.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct AppTextFieldModifier: ViewModifier {
	
	// Environment
	@Environment(\.preferredPalettes) var palettes

	
	// MARK: ViewModifier Methods
	func body(content: Content) -> some View {
		content
//			.textFieldStyle(.roundedBorder)
			.padding(8)
//			.overlay(RoundedRectangle(cornerRadius: 10).stroke(palettes.color.tertiary, lineWidth: 1))
			.overlay(Rectangle().stroke(palettes.color.tertiary, lineWidth: 1))
	}
}


// MARK: - TextField Extension
extension TextField {
	
	func appTextField() -> ModifiedContent<TextField<Label>, AppTextFieldModifier> {
		return self.modifier(AppTextFieldModifier())
	}
}


// MARK: - Preview
struct AppTextFieldModifier_Previews: PreviewProvider {
	@State static var text: String = ""
	
	static var previews: some View {
		Group {
			TextField("Title", text: $text)
				.appTextField()
				.preferredColorScheme(.light)

			TextField("Title", text: $text)
				.appTextField()
			.preferredColorScheme(.dark)
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
