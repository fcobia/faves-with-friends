//
//  ErrorAlertView.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI

struct ErrorAlertView: View {
	typealias DismissAction = (DisplayableErrorInfo) -> Void
	
	
	// MARK: Private Variables
	private let errorInfo: DisplayableErrorInfo
	private let dismissAction: DismissAction
	
	
	// MARK: SwiftUI
    var body: some View {
		VStack {
			Text("An error")
			Button("OK") {
				dismissAction(errorInfo)
			}
		}
    }
	
	
	// MARK: Init
	
	init(errorInfo: DisplayableErrorInfo, dismissAction: @escaping DismissAction) {
		self.errorInfo = errorInfo
		self.dismissAction = dismissAction
	}
}



private struct ButtonInfoWrapper: Identifiable {
	let id = UUID()
	let button: DisplayableErrorInfoButton
}


//struct ErrorAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorAlertView()
//    }
//}
