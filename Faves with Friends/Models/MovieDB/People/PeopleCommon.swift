//
//  PeopleCommon.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/6/21.
//

import Foundation


protocol PeopleCommon: Identifiable {
	
	// MARK: JSON Variables
	var id: Int { get }
	var name: String { get }
	var profilePathString: String? { get }
}


extension PeopleCommon {
	
	var profilePath: URL? {
		guard let profilePathString = profilePathString else {
			return nil
		}
		
		return URL(string: "https://image.tmdb.org/t/p/original\(profilePathString)")
	}
}
