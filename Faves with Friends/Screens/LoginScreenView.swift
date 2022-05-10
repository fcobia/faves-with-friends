//
//  LoginScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


struct LoginScreenView: View {
	
	// Environment
	@Environment(\.environmentManager) var environmentManager

	// MARK: State Variables
	@State var username: String = ""
	@State var password: String = ""
	
	
	// MARK: SwiftUI
    var body: some View {
		
		VStack {
			
			Text("ShowZ")
				.font(.largeTitle.weight(.semibold))
				.appText()
			
			TextField("Email", text: $username)
				.appTextField()
				.padding()

			SecureField("Password", text: $password)
				.appSecureField()
				.padding([.leading, .trailing, .bottom])
			
			Button("Login") {
				Task {
					await loginPressed()
				}
			}
				.appPrimaryButton()
				.padding([.leading, .trailing, .bottom])
			
			Button("Sign Up") {
				
			}
				.appSecondaryButton()
				.padding([.leading, .trailing, .bottom])
		}
    }
	
	
	// MARK: Private Methods
	
	private func loginPressed() async {
		do {
			let _ = try await environmentManager.userManager.login(username: username, password: password, remember: true)
		}
//		catch UserNetworkTokenError.noUser {
//			print("Got invalid login")
//		}
		catch let error {
			print("Got error Type: \(type(of: error))")
			print("Got error: \(error)")
		}
	}
}


struct LoginScreenView_Previews: PreviewProvider {
	static var previews: some View {
		LoginScreenView()
	}
}
