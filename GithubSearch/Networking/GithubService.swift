//
//  GithubService.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 12/07/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa

class GithubService {

	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func search(_ query: String) -> Observable<[Repository]> {
		let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
		let url = URL(string: "https://api.github.com/search/repositories?q=\(encodedQuery)&sort=stars&order=desc")!
		return session.rx
			.json(url: url)
			.flatMap { json throws -> Observable<[Repository]> in
				guard
					let json = json as? [String: Any],
					let itemsJSON = json["items"] as? [[String: Any]]
				else { return Observable.error(APIError.parsingError) }

				let repositories = itemsJSON.compactMap(Repository.init)
				return Observable.just(repositories)
			}
	}
}
