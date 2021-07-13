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

final class SearchViewController: UIViewController {

	// MARK: Outlets
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	// MARK: Properties
	private let disposeBag = DisposeBag()
	private let cellIdentifier = R.nib.repoTableViewCell.identifier

	var viewModel: RepoSearchViewModel!

	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupBindings()
		selectionBindings()
	}

}

// MARK: - Setup UI
private extension SearchViewController {
	func setupUI() {
		self.navigationItem.title = "Github Search"
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 100
		configureSearchBarUI()
		configureTableView()
	}

	func configureTableView() {
		tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
	}

	func configureSearchBarUI() {
		self.searchBar.backgroundColor = UIColor.clear
		self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		searchBar.semanticContentAttribute = .forceRightToLeft

		if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
			textfield.backgroundColor = UIColor.black.withAlphaComponent(0.5)
			let key = NSAttributedString.Key.foregroundColor
			let color = UIColor.lightGray
			let text = textfield.placeholder ?? ""
			textfield.attributedPlaceholder = NSAttributedString(string: text, attributes: [key: color])
			textfield.font = UIFont.systemFont(ofSize: 15.0)

			if let leftView = textfield.leftView as? UIImageView {
				leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
				leftView.tintColor = UIColor.lightGray
			}
		}

	}
}

// MARK: - Setup Bindings
private extension SearchViewController {
	func setupBindings() {
		_ = searchBar.rx.text.orEmpty
			.bind(to: viewModel.searchText)
			.disposed(by: disposeBag)

		viewModel.repositories
		.observe(on: MainScheduler.instance)
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: RepoTableViewCell.self)) { (_, viewModel, cell) in
				cell.viewModel = viewModel
		}.disposed(by: disposeBag)

		viewModel.alertMessage
			.subscribe(onNext: { [weak self] in self?.showAlert(message: $0) })
			.disposed(by: disposeBag)
	}

	func selectionBindings() {
		tableView.rx.modelSelected(RepoViewModel.self)
			.observe(on: MainScheduler.instance)
			.bind(to: viewModel.selectedRepo)
			.disposed(by: disposeBag)
	}

}
