//
//  RepoDetailsCoordinator.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import RxSwift

class RepoDetailsCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	var viewModel: RepoViewModel!

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {
		let viewController = R.storyboard.main.repoDetailsViewController()!
		viewController.viewModel = viewModel

		let didClose = viewModel.didClose

		rootViewController.show(viewController, sender: nil)

		return didClose
			.take(1)
	}

}
