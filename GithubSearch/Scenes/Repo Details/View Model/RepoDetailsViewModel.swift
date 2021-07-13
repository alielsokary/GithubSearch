//
//  RepoDetailsViewModel.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa

class RepoDetailsViewModel {

	private let disposeBag = DisposeBag()

	// MARK: - Properties
	let repoName = BehaviorRelay<String>(value: "")
	let repoDescription = BehaviorRelay<String>(value: "")
	let repoStarsCount = BehaviorRelay<String>(value: "")
	let repoCreationDate = BehaviorRelay<String>(value: "")

	func setRepoName(_ name: String) {
		repoName.accept(name)
	}

	func setRepoDescription(_ desc: String) {
		repoDescription.accept(desc)
	}

	func setRepoStarsCount(_ count: Int) {
		repoStarsCount.accept("Stars: \(count)")
	}

	func setRepoCreationDate(_ date: String) {
		repoCreationDate.accept(date.formatedDate)
	}
}
