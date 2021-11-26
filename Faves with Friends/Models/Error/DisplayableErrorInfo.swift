//
//  DisplayableErrorInfo.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 11/25/21.
//

import Foundation


protocol DisplayableErrorInfo {
	var title: String? { get }
	var message: String? { get }
	var buttons: [DisplayableErrorInfoButton]? { get }
}
