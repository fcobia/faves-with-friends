//
//  CastCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


protocol CastCreditEntry: CreditEntry {
	var character: String? { get }
}


// MARK: Default Implementations
extension CastCreditEntry {
	
	var creditName: String? {
		return character
	}
}
