//
//  AlertManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import SwiftUI


final class AlertManager: ObservableObject {
	
	// MARK: Public Computed Variables
	var hasErrorToDisplay: Bool {
		return !alerts.isEmpty
	}
	
	var errorToDisplay: DisplayableErrorInfo? {
		return alerts.first
	}
	
	var alertTitle: String {
		guard let info = errorToDisplay, let title = info.title else {
			return "Error"
		}
		
		return title
	}
	
	
	// MARK: Private Variables
	private var alerts: [DisplayableErrorInfo] = []
	
	
	// MARK: Public Methods
	
	func showAlert(for error: Error) {
		
		// ObservableObject
		self.objectWillChange.send()
		
		alerts.append(LocalDisplayableErrorInfo(title: nil, message: nil, buttons: nil))
	}
	
	func createAlertView(errorInfo: DisplayableErrorInfo) -> some View {
		ErrorAlertView(errorInfo: errorInfo) { [weak self] errorInfo in
			self?.dismissAlert()
		}
	}
	
	
	// MARK: Private Methods
	
	private func dismissAlert() {
		
		// ObservableObject
		self.objectWillChange.send()
		
		alerts.removeFirst()
	}
}


private struct LocalDisplayableErrorInfo: DisplayableErrorInfo {
	let title: String?
	let message: String?
	let buttons: [DisplayableErrorInfoButton]?
}
