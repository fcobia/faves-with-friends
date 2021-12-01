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
	}
	
	private func setupNavigationBarAppearance() {
        let textColor = UIColor(.white)
//		
		let appearance = UINavigationBarAppearance()
//		appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  UIColor(.blue)
		appearance.titleTextAttributes = [.foregroundColor: textColor]
		appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
		
		UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
		UINavigationBar.appearance().compactAppearance = appearance
	}
}
