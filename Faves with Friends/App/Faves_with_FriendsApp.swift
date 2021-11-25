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
					.foregroundColor(palettes.color.primaryText)
					.environment(\.preferredPalettes, palettes)
					.environment(\.environmentManager, environmentManager)
			}
			else {
				LaunchScreenView(hasLaunched: $hasLaunched)
			}
        }
    }
}
