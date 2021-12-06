//
//  DateFormatters.swift
//  Faves with Friends
//
//  Created by Frank Cobia on 12/5/21.
//

import Foundation


enum DateFormatters {
	
	static let dateOnly: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .short
		df.timeStyle = .none
		
		return df
	}()
}
