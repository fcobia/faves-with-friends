//
//  AppRoundedTextFieldModifier.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 11/27/21.
//

import SwiftUI


struct AppRoundedTextFieldModifier: ViewModifier {
    
    // Environment
    @Environment(\.preferredPalettes) var palettes

    
    // MARK: ViewModifier Methods
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .padding(8)
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(palettes.color.tertiary, lineWidth: 1))
//            .overlay(Rectangle().stroke(palettes.color.tertiary, lineWidth: 1))
    }
}


// MARK: - TextField Extension
extension TextField {
    
    func appRoundedTextField() -> ModifiedContent<TextField<Label>, AppRoundedTextFieldModifier> {
        return self.modifier(AppRoundedTextFieldModifier())
    }
}


// MARK: - Preview
struct AppRoundedTextFieldModifier_Previews: PreviewProvider {
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
        .previewLayout(.sizeThatFits)
    }
}
