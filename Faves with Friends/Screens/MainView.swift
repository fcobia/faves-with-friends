//
//  MainView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct MainView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager

	
	// MARK: SwiftUI
	var body: some View {
		Group {
			
			// Have we finished launching
			TabView {
				
				// Tab 1
				NavigationView {
					Text("Tab 1")
				}
				.tabItem {
					Text("Tab 1")
				}
				
				// Tab 2
				NavigationView {
					Text("Tab 2")
				}
				.tabItem {
					Text("Tab 2")
				}
			}
			.navigationViewStyle(.stack)
		}
	}
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
