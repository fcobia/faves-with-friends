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
	
	// MARK: EnvironmentObjects
	@EnvironmentObject var alertManager: AlertManager
	
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
		.alert(alertManager.alertTitle, isPresented: .constant(alertManager.hasErrorToDisplay), presenting: alertManager.errorToDisplay, actions: alertManager.createAlertView)
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
