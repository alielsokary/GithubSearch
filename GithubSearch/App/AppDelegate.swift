//
//  AppDelegate.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 08/07/2021.
//  
//

import UIKit
import RxSwift
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var appCoordinator: AppCoordinator!
	private let disposeBag = DisposeBag()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		NFX.sharedInstance().start()
		window = UIWindow()

		appCoordinator = AppCoordinator(window: window!)
		appCoordinator.start()
			.subscribe()
			.disposed(by: disposeBag)
		return true
	}

}
