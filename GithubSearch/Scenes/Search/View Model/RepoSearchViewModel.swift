//
//  RepoSearchViewModel.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa

class RepoSearchViewModel {

	private let service: GithubService

	// MARK: - Properties
	let searchText = BehaviorRelay<String>(value: "")

	private let _alertMessage = PublishSubject<String>()
	private let _reposSubject = PublishSubject<[RepoViewModel]>()

	let selectedRepo = PublishSubject<RepoViewModel>()

	var repositories: Observable<[RepoViewModel]>

	let alertMessage: Observable<String>

	init(service: GithubService) {
		self.service = service
		self.repositories = _reposSubject.asObserver()
		self.alertMessage = _alertMessage.asObserver()

		self.repositories = searchText.map { $0 }
			.filter({ $0.count > 1 })
			.throttle(.milliseconds(300), scheduler: MainScheduler.instance)
			.distinctUntilChanged()
			.flatMapLatest { [weak self] query -> Observable<[RepoViewModel]> in
				guard let self =  self else { return .just([]) }
				if query.isEmpty {
					return .just([])
				}
				return self.service.search(query)
					.catch { error in
						self._alertMessage.onNext(error.localizedDescription)
						return Observable.empty()
					}.map {
						let repoItems = $0.items?.compactMap { RepoViewModel(repo: $0) }
						return repoItems!
					}
			}
	}

}
