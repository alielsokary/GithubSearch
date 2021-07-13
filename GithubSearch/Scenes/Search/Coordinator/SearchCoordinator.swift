//
//  SearchCoordinator.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import RxSwift

class SearchCoordinator: BaseCoordinator<Void> {

	let rootViewController: UIViewController

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	let service = GithubServiceImpl()

	override func start() -> Observable<Void> {
		let viewController = rootViewController as? SearchViewController
		let viewModel = RepoSearchViewModel(service: service)
		viewController?.viewModel = viewModel

		viewModel.selectedRepo
			.flatMap({ [unowned self] (repoViewModel) in
				self.coordinateToRepoDetail(with: repoViewModel)
			})
			.subscribe()
			.disposed(by: disposeBag)

		return Observable.empty()
	}

	// MARK: - Coordination
	private func coordinateToRepoDetail(with repoViewModel: RepoViewModel) -> Observable<Void> {
		let repoDetailsCoordinator = RepoDetailsCoordinator(rootViewController: rootViewController)
		repoDetailsCoordinator.viewModel = repoViewModel
		return coordinate(to: repoDetailsCoordinator)
			.map { _ in () }
	}
}
