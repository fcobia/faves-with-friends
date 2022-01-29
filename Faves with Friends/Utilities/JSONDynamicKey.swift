//
//  JSONDynamicKey.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/29/22.
//

import Foundation


struct JSONDynamicKey: CodingKey {
	
	// MARK: Variables
	let stringValue: String
	let intValue: Int?
	
	
	// MARK: Init
	init?(intValue: Int) {
		self.intValue = intValue
		self.stringValue = "\(intValue)"
	}
	
	init?(stringValue: String) {
		self.stringValue = stringValue
		self.intValue = nil
	}
}
