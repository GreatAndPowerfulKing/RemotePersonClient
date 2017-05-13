//
//  Date+Format.swift
//  RemotePerson
//
//  Created by iKing on 13.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import Foundation

extension Date {
	
	func formated(with format: String) -> String {
		let formatter = DateFormatter(format: format)
		return formatter.string(from: self)
	}
	
	static func fromString(_ string: String, format: String) -> Date? {
		let formatter = DateFormatter(format: format)
		return formatter.date(from: string)
	}
}

extension DateFormatter {
	
	convenience init(format: String) {
		self.init()
		self.dateFormat = format
	}
}
