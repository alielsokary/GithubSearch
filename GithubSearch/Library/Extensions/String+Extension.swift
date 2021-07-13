//
//  String+Extension.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import Foundation

extension String {

	var formatedDate: String {
		var str = self
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

		if let date = formatter.date(from: str) {

			formatter.dateFormat = "yyyy-MM-d"
			let outputDate = formatter.string(from: date)
			str = outputDate
		}
		return str
	}

}
