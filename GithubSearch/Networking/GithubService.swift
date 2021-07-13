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

protocol GithubService {
	func search(_ query: String) -> Observable<Repositories>
}

class GithubServiceImpl: GithubService {

	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func search(_ query: String) -> Observable<Repositories> {
		let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
		let url = URL(string: "https://api.github.com/search/repositories?q=\(encodedQuery)&sort=stars&order=desc&per_page=10")!
		let req = URLRequest(url: url)
		return session.rx.data(request: req)
			.flatMap { data throws -> Observable<Repositories> in

				let decoder = JSONDecoder()
				do {
					return try Observable.of(decoder.decode(Repositories.self, from: data))
				}
			}
	}

}
