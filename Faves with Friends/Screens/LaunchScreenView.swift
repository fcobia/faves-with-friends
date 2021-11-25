//
//  LaunchScreenView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI

struct LaunchScreenView: View {
	
	// MARK: Binding Variables
	@Binding private var hasLaunched: Bool
	
	
	// MARK: SwiftUI
	var body: some View {
		Text("Launch Screen")
			.appText()
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
					self.hasLaunched = true
				}
			}
	}
	
	
	// MARK: Init
	
	init(hasLaunched: Binding<Bool>) {
		self._hasLaunched = hasLaunched
	}
}


struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
		LaunchScreenView(hasLaunched: .constant(true))
    }
}
