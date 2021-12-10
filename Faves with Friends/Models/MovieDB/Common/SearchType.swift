//
//  SearchType.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/9/21.
//

import Foundation


enum SearchType: String, CaseIterable, Identifiable {
	case all		= "All"
	case movies		= "Movies"
	case tv			= "TV"
	case person		= "People"
	
	
	// MARK: Identifiable
	var id: String {
		self.rawValue
	}
}
