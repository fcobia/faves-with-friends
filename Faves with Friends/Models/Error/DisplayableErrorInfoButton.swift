//
//  DisplayableErrorInfoButton.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


enum DisplayableErrorInfoButton {
	typealias ButtonAction = () -> Void
	
	case title(String)
	case action(ButtonAction)
	case titleAndAction(String, ButtonAction)
}

