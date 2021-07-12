//
//  APIError.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 08/07/2021.
//  
//

import Foundation

enum APIError: Error {
	case badRequest
	case notFound
	case requestTimeout
	case internalServerError
	case gatewatTimeout
	case parsingError
	case unknownError
}

extension APIError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .badRequest:
			return "Bad request, server cannot perform request"
		case .notFound:
			return "We cannot find this page, please try again"
		case .requestTimeout:
			return "Request timeout"
		case .internalServerError:
			return "Internal Server error"
		case .gatewatTimeout:
			return "Gateway timeout"
		case .parsingError:
			return "Error parsing the request"
		case .unknownError:
			return "Something went wrong, please try again later"
		}
	}
}
