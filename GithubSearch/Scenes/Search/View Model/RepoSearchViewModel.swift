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

	private let service = GithubService()

	// MARK: - Properties
	let searchText = BehaviorRelay<String>(value: "")

	private let _alertMessage = PublishSubject<String>()
	private let _repositorySubject = PublishSubject<[Repository]>()

	var repository: Observable<[Repository]>
	let alertMessage: Observable<String>

	init() {
		self.repository = _repositorySubject.asObserver()
		self.alertMessage = _alertMessage.asObserver()

		self.repository = searchText.map { $0 }
			.filter({ $0.count > 1 })
			.throttle(.milliseconds(300), scheduler: MainScheduler.instance)
			.distinctUntilChanged()
			.flatMapLatest { [weak self] query -> Observable<[Repository]> in
				guard let self =  self else { return .just([]) }
				if query.isEmpty {
					return .just([])
				}
				return self.service.search(query)
					.catch { error in
						self._alertMessage.onNext(error.localizedDescription)
						return Observable.empty()
					}.map {
						return $0.items ?? []
					}
			}
	}

}
