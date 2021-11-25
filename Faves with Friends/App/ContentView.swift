//
//  ContentView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/24/21.
//

import SwiftUI
import Combine


struct ContentView: View {
	
	// MARK: Environment Variables
	@Environment(\.environmentManager) private var environmentManager: EnvironmentManager
	
	// MARK: State Variables
	@State private var user: User?

	
	// MARK: SwiftUI
	var body: some View {
		Group {
			
			if let user = user {
				MainView()
					.environment(\.user, user)
			}
			else {
				LoginScreenView()
			}
		}
		.onReceive(environmentManager.userManager.userPublisher) { user in
			self.user = user
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
