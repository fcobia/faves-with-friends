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
	
	
	// MARK: Private Variables
	private var alerts: [DisplayableErrorInfo] = []

	
	// MARK: Public Methods
	
	func showAlert(title: String?, message: String?, buttons: [DisplayableErrorInfoButton]?, allowAppend: Bool = false) {
		showAlert(for: ErrorInfo(title: title, message: message, buttons: buttons), allowAppend: allowAppend)
	}
	
	func showAlert(for error: Error, allowAppend: Bool = false) {
		showAlert(for: ErrorInfo(), allowAppend: allowAppend)
	}
	
	func showAlert(for displayableErrorInfo: DisplayableErrorInfo, allowAppend: Bool = false) {
		
		DispatchQueue.main.async {
			
			// Make sure we are allowed to append
			guard self.alerts.count == 0 || allowAppend == true else {
				return
			}
			
			// ObservableObject
			self.objectWillChange.send()
			
			self.alerts.append(displayableErrorInfo)
		}
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


// MARK: - For View
extension AlertManager {
	
	// MARK: Public Computed Variables
	var alertTitle: String {
		guard let info = errorToDisplay, let title = info.title else {
			return StringConstants.Errors.defaultErrorTitle
		}
		
		return title
	}
	
	
	// MARK: Public Functions
	
	func alertMessage(_ errorToDisplay: DisplayableErrorInfo) -> some View {
		Text(errorToDisplay.message ?? StringConstants.Errors.defaultErrorMessage)
	}
	
	func alertActions(_ errorToDisplay: DisplayableErrorInfo) -> some View {
		ForEach(alertButtonWrappers(errorToDisplay: errorToDisplay)) { buttonWrapper in
			Button(buttonWrapper.title) {
				buttonWrapper.action?()
				self.dismissAlert()
			}
		}
	}
	
	
	// MARK: Private Computed Variables

	private func alertButtonWrappers(errorToDisplay: DisplayableErrorInfo) -> [ButtonInfoWrapper] {
		
		// Get the set of buttons
		let buttonWrappers: [DisplayableErrorInfoButton]
		if let infoButtons = errorToDisplay.buttons, !infoButtons.isEmpty {
			buttonWrappers = infoButtons
		}
		else {
			buttonWrappers = [.title(StringConstants.Errors.defaultErrorButtonTitle)]
		}
		
		return buttonWrappers.map({ .init(button: $0) })
	}
}


// MARK: - DisplayableErrorInfoWithButtons
extension AlertManager {
	
	struct ErrorInfo: DisplayableErrorInfo {
		
		// Variables
		let title: String?
		let message: String?
		let buttons: [DisplayableErrorInfoButton]?
		
		
		// Init
		
		init(title: String? = nil, message: String? = nil, buttons: [DisplayableErrorInfoButton]? = nil) {
			self.title = title
			self.message = message
			self.buttons = buttons
		}
	}
}


// MARK: - ButtonInfoWrapper
private struct ButtonInfoWrapper: Identifiable {
	let id = UUID()
	let title: String
	let action: (() -> Void)?
	
	
	init(button: DisplayableErrorInfoButton) {
		
		switch button {
				
			case .title(let title):
				self.title = title
				self.action = nil
				
			case .action(let buttonAction):
				self.action = buttonAction
				self.title = StringConstants.Errors.defaultErrorTitle
				
			case .titleAndAction(let title, let buttonAction):
				self.title = title
				self.action = buttonAction
		}
	}
}
