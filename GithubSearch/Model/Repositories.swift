//
//  Repositories.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 08/07/2021.
//  
//

import Foundation

// MARK: - Repositories
struct Repositories: Codable {
	let totalCount: Int?
	let incompleteResults: Bool?
	let items: [Repository]?

	enum CodingKeys: String, CodingKey {
		case totalCount = "total_count"
		case incompleteResults = "incomplete_results"
		case items
	}
}
