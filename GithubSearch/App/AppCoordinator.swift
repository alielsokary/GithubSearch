//
//  AppCoordinator.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

	var window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	override func start() -> Observable<Void> {
		guard let viewcontroller = R.storyboard.main.searchViewController() else { return  Observable.empty() }
		let navigationController = UINavigationController(rootViewController: viewcontroller)

		let seasonsCoordinator = SearchCoordinator(rootViewController: navigationController.viewControllers[0])

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		return coordinate(to: seasonsCoordinator)
	}
}
