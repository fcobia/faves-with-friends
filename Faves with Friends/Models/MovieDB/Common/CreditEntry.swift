//
//  CreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


protocol CreditEntry {
	var id: Int { get }
	var name: String? { get }
	var creditName: String? { get }
	var image: URL? { get }
}
