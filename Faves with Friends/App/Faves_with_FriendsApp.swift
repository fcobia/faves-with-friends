//
//  Faves_with_FriendsApp.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import SwiftUI

@main
struct Faves_with_FriendsApp: App {
	
	// MARK: AppDelegate
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	// MARK: State Variables
	@State private var hasLaunched			= false
	@State private var palettes				= Palettes.standard
	@State private var environmentManager	= AppEnvironmentManager.createDefault()
	
	
	// MARK: SwiftUI
    var body: some Scene {
        WindowGroup {
			
			if hasLaunched {
				ContentView()
					.modifier(EnvironmentModifier(palettes: palettes, environmentManager: environmentManager))
			}
			else {
				LaunchScreenView(hasLaunched: $hasLaunched)
			}
        }
    }
}


// MARK: - EnvironmentModifier
private struct EnvironmentModifier: ViewModifier {
	
	// Private Variables
	private var palettes			= Palettes.standard
	private var environmentManager	= AppEnvironmentManager.createDefault()

	
	// Init
	init(palettes: Palettes, environmentManager: EnvironmentManager) {
		self.palettes = palettes
		self.environmentManager = environmentManager
	}
	
	
	// ViewModifier
	func body(content: Content) -> some View {
		content
			.foregroundColor(palettes.color.primaryText)
			.environment(\.preferredPalettes, palettes)
			.environment(\.environmentManager, environmentManager)
			.environmentObject(AlertManager())
	}
}


// MARK: - Preview
struct Faves_with_FriendsApp_Previews: PreviewProvider {
	
	// Public Methods
	static var previewEnvironmentModifier: some ViewModifier {
		createPreviewEnvironment(loggedIn: true)
	}
	
	// Private Methods
	static var previewEnvironmentModifierNotLoggedIn: some ViewModifier {
		createPreviewEnvironment(loggedIn: false)
	}

	private static func createPreviewEnvironment(loggedIn: Bool) -> EnvironmentModifier {
		EnvironmentModifier(
			palettes: Palettes.standard,
			environmentManager: AppEnvironmentManager.createPreview(loggedIn: loggedIn))
	}
	
	// Preview
	static var previews: some View {
		Group {
			ContentView()
				.modifier(previewEnvironmentModifier)
			
			ContentView()
				.modifier(previewEnvironmentModifierNotLoggedIn)
		}
	}
}
