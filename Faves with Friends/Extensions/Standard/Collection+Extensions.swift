//
//  Collection+Extensions.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/26/22.
//

import Foundation


extension Collection where Element: Identifiable {

	var withoutDuplicates: [Element] {
		var ids = Set<Element.ID>()
		var results = [Element]()
		
		for element in self {
			let id = element.id
			
			if ids.contains(id) == false {
				results.append(element)
				ids.insert(id)
			}
		}
		
		return results
	}
}
