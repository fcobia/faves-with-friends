//
//  RowViewButton.swift
//  Faves with Friends
//
//  Created by CHRIS RINER on 3/27/22.
//

import Foundation

import SwiftUI


struct RowViewButtonModifier: ViewModifier {
    
    // Environment
    @Environment(\.preferredPalettes) var palettes

    
    // MARK: ViewModifier Methods
    func body(content: Content) -> some View {
        content
            .buttonStyle(RowViewButtonStyle())
    }
}


// MARK: - TextField Extension
extension Button {
    
    func rowViewButton() -> ModifiedContent<Button, RowViewButtonModifier> {
        return self.modifier(RowViewButtonModifier())
    }
}


// MARK: - Button Style
private struct RowViewButtonStyle: ButtonStyle {
    
    // Environment
    @Environment(\.preferredPalettes) var palettes

    
    // MARK: ButtonStyle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .font(.caption)
            .foregroundColor(palettes.color.alternativeText)
            .background(palettes.color.primary, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
