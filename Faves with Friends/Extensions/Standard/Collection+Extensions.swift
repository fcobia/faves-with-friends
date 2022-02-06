//
//  Collection+Extensions.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 1/26/22.
//

import Foundation


extension Collection where Element: Identifiable {

	var withoutDuplicates: [Element] {
		removeDuplicates(keyPath: \.id)
	}
}

extension Collection {
	
	func removeDuplicates<T: Equatable & Hashable>(keyPath: KeyPath<Element,T>) -> [Element] {
		var ids = Set<T>()
		var results = [Element]()
		
		for element in self {
			let id = element[keyPath: keyPath]
			
			if ids.contains(id) == false {
				results.append(element)
				ids.insert(id)
			}
		}
		
		return results
	}
}
