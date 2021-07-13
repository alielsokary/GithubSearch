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
	@IBOutlet private weak var lblName: UILabel!
	@IBOutlet private weak var lblDescription: UILabel!
	@IBOutlet private weak var lblStarsCount: UILabel!
	@IBOutlet private weak var lblCreatedAt: UILabel!

	// MARK: Properties
	var viewModel: RepoViewModel!
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupBindings()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModel.didClose.onNext(())
	}

}

// MARK: - Setup UI
private extension RepoDetailsViewController {
	func setupUI() {
		lblName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		lblDescription.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		lblCreatedAt.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblStarsCount.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
		lblName.textColor = UIColor.red.withAlphaComponent(0.5)
		lblDescription.textColor = UIColor.black
		lblCreatedAt.textColor = UIColor.blue.withAlphaComponent(0.5)
		lblStarsCount.textColor = UIColor.black

	}
}

// MARK: - Setup Bindings
private extension RepoDetailsViewController {
	func setupBindings() {
		self.navigationItem.title = viewModel.fullName
		self.lblName?.text = viewModel.name
		self.lblDescription?.text = viewModel.description
		self.lblStarsCount?.text = "Stars: \(viewModel.stars)"
		self.lblCreatedAt?.text = viewModel.createdAt
	}
}
