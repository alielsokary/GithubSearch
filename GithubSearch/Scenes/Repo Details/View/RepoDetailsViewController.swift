//
//  RepoDetailsViewController.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import UIKit
import RxSwift
import RxCocoa

final class RepoDetailsViewController: UIViewController {

	// MARK: Outlets
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblDescription: UILabel!
	@IBOutlet weak var lblStarsCount: UILabel!
	@IBOutlet weak var lblCreatedAt: UILabel!

	let viewModel = RepoDetailsViewModel()
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupBindings()
	}

}

// MARK: Setup UI
private extension RepoDetailsViewController {
	func setupUI() {
		lblName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		lblDescription.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		lblCreatedAt.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblStarsCount.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblName.textColor = UIColor.red.withAlphaComponent(0.5)
		lblDescription.textColor = UIColor.black
		lblCreatedAt.textColor = UIColor.blue.withAlphaComponent(0.5)
		lblStarsCount.textColor = UIColor.black
	}
}

// MARK: Setup Bindings
private extension RepoDetailsViewController {
	func setupBindings() {
		viewModel.repoName
			.bind(to: lblName.rx.text)
			.disposed(by: disposeBag)

		viewModel.repoDescription
			.bind(to: lblDescription.rx.text)
			.disposed(by: disposeBag)

		viewModel.repoStarsCount
			.bind(to: lblStarsCount.rx.text)
			.disposed(by: disposeBag)

		viewModel.repoCreationDate
			.bind(to: lblCreatedAt.rx.text)
			.disposed(by: disposeBag)
	}
}
