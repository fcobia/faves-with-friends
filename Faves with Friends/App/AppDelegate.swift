//
//  AppDelegate.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
	
	
	// MARK: UIApplicationDelegate
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
		// Setup the appearance
		setupAppearance()
		
		return true
	}
	
	
	// MARK: Private Methods
	
	private func setupAppearance() {
		
		// Navigation Bar
		setupNavigationBarAppearance()
		
		// Tab Bar
		setupTabBarUI()
	}
	
	private func setupTabBarUI() {
		let nonSelectedColor = UIColor(named: "Standard/tertiary")!
		let selectedColor = UIColor(named: "Standard/text-alt")!
		let primaryColor = UIColor(named: "Standard/primary")

		let appearance = UITabBarAppearance()

		// Background
		appearance.backgroundColor = primaryColor

		// Not selected
		appearance.stackedLayoutAppearance.normal.iconColor = nonSelectedColor
		appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: nonSelectedColor]

		// Selected
		appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
		appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

		UITabBar.appearance().standardAppearance = appearance
		UITabBar.appearance().scrollEdgeAppearance = appearance
	}

	private func setupNavigationBarAppearance() {
		let textColor = UIColor(named: "Standard/text-alt")!
		let primaryColor = UIColor(named: "Standard/primary")
		
		let appearance = UINavigationBarAppearance()
        appearance.backgroundColor =  primaryColor
		appearance.titleTextAttributes = [.foregroundColor: textColor]
		appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
		
		UINavigationBar.appearance().tintColor = textColor

		UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
		UINavigationBar.appearance().compactAppearance = appearance
	}
}
