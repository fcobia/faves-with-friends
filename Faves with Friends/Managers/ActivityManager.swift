//
//  ActivityManager.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/28/21.
//

import Foundation


final class ActivityManager: ObservableObject {
	
	// MARK: Public Computed Variables
	var shouldShowActivity: Bool {
		showCount > 0
	}
	
	// MARK: Private Published Variables
	@Published private var showCount: Int = 0
	
	
	// MARK: Public Methods
	
	public func showActivity() {
		DispatchQueue.main.async {
			self.showCount += 1
		}
	}
	
	public func hideActivity() {
		DispatchQueue.main.async {
			guard self.showCount > 0 else { return }
			
			self.showCount -= 1
		}
	}
}
