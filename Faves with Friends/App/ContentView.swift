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
	@EnvironmentObject var activityManager: ActivityManager

	// MARK: State Variables
	@State fileprivate var user: User?

	
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
		.alert(alertManager.alertTitle, isPresented: .constant(alertManager.hasErrorToDisplay), presenting: alertManager.errorToDisplay, actions: alertManager.alertActions, message: alertManager.alertMessage)
		.overlay {
			if activityManager.shouldShowActivity {
				ProgressView()
					.tint(.white)
					.scaleEffect(2.5)
					.ignoresSafeArea()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.black.opacity(0.3))

			}
		}
		.onReceive(environmentManager.userManager.userPublisher) { user in
			self.user = user
		}
	}
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
	
	// Public Methods
	static var previewEnvironmentModifier: some ViewModifier {
		EnvironmentModifier()
	}

	private static let testUser = User(email: "test@test.com")
	
	static func createContntView() -> some View {
		let result = ContentView()
		result.user = testUser
		
		return result
	}
	
    static var previews: some View {
		createContntView()
			.modifier(previewEnvironmentModifier)
    }

	
	// MARK: - EnvironmentModifier
 private struct EnvironmentModifier: ViewModifier {	 
	 
	 // ViewModifier
	 func body(content: Content) -> some View {
		 content
			 .modifier(Faves_with_FriendsApp_Previews.previewEnvironmentModifier)
			 .environment(\.user, testUser)
		 
	 }
 }
}
