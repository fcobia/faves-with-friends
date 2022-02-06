//
//  CrewCreditEntry.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 2/6/22.
//

import Foundation


protocol CrewCreditEntry: CreditEntry {
	var job: String? { get }
}


// MARK: Default Implementations
extension CrewCreditEntry {
	
	var creditName: String? {
		return job
	}
}
