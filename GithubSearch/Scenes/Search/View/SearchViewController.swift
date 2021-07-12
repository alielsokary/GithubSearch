//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 08/07/2021.
//  
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		let service = GithubService()

		service.search("tetris")
			.subscribe { [weak self] repo in
			print(repo)
		}.disposed(by: disposeBag)

	}

}
