//
//  GithubRouter.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 08/07/2021.
//  
//

import Foundation

enum GithubRouter {
	case search(query: String)

	private var baseURL: String {
		return "https://api.github.com/"
	}

	private var path: String {
		switch self {
		case .search:
			return "search/repositories"
		}
	}

	private var method: String {
		switch self {
		case .search(_):
			return "GET"
		}
	}

	private var parameters: [String: Any]? {
		var params = [String: Any]()

		switch self {
		case .search(let query):
			params["q"] = query
			params["sort"] = "stars"
			params["order"] = "desc"
			return params
		}
	}

	func request() -> URLRequest? {
		guard let url = URL(string: baseURL + path) else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = method

		if parameters != nil {
			do {
				request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
			} catch let error {
				print(error.localizedDescription)
				return nil
			}
		}

		return request
	}
}
