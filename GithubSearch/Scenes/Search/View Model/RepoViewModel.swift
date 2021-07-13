//
//  RepoViewModel.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import Foundation
import RxSwift

struct RepoViewModel {

	let didClose = PublishSubject<Void>()

	let name: String
	let fullName: String
	let description: String
	let stars: Int
	let createdAt: String
	let ownerName: String
	let ownerAvatar: String

	init(repo: Repository) {
		self.name = repo.name ?? ""
		self.fullName = repo.fullName ?? ""
		self.description = repo.itemDescription ?? ""
		self.stars = repo.stargazersCount ?? 0
		self.createdAt = repo.createdAt?.formatedDate ?? ""
		self.ownerName = repo.owner?.login ?? ""
		self.ownerAvatar = repo.owner?.avatarURL ?? ""
	}

}
