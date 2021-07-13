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

	let service = GithubService()

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
			.filter({ $0.count > 1 })
			.throttle(.milliseconds(300), scheduler: MainScheduler.instance)
			.distinctUntilChanged()
			.flatMapLatest { query -> Observable<[Repository]> in
				if query.isEmpty {
					return .just([])
				}
				return self.service.search(query)
					.catch { error in
						print(error)
				  return Observable.empty()
					}.map { $0.items ?? [] }
		}.observe(on: MainScheduler.instance)
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: RepoTableViewCell.self)) { [weak self] (_, repo, cell) in
				self?.setupCell(cell: cell, repo: repo)
		}
		.disposed(by: disposeBag)
	}

	func selectionBindings() {
		Observable
			.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Repository.self))
			.observe(on: MainScheduler.instance)
			.bind { [weak self] _, repo in
				guard let self = self else { return }
				guard let repoDetailsVC = R.storyboard.main.repoDetailsViewController() else { return }
				repoDetailsVC.viewModel.setRepoName(repo.name ?? "")
				repoDetailsVC.viewModel.setRepoDescription(repo.itemDescription ?? "")
				repoDetailsVC.viewModel.setRepoStarsCount(repo.stargazersCount ?? 0)
				repoDetailsVC.viewModel.setRepoCreationDate(repo.createdAt ?? "")
				self.show(repoDetailsVC, sender: nil)
			}
		.disposed(by: disposeBag)
	}

	private func setupCell(cell: RepoTableViewCell, repo: Repository) {
		cell.selectionStyle = .none
		cell.setTitle(repo.fullName ?? "")
		cell.setOwnerName(repo.owner?.login ?? "")
		cell.setOwnerAvatar(repo.owner?.avatarURL ?? "")
		cell.setDate(repo.createdAt?.formatedDate ?? "")
	}
}
