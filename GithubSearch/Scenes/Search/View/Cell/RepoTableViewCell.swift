//
//  RepoTableViewCell.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 12/07/2021.
//  
//

import UIKit

class RepoTableViewCell: UITableViewCell {

	@IBOutlet weak var imgvAvatar: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblOwnerName: UILabel!
	@IBOutlet weak var lblCreatedAt: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
		setupUI()
    }

	private func setupUI() {
		lblName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		lblOwnerName.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblCreatedAt.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblName.textColor = UIColor.red.withAlphaComponent(0.5)
		lblCreatedAt.textColor = UIColor.blue.withAlphaComponent(0.5)

	}

	var viewModel: RepoViewModel! {
		didSet {
			self.configure()
		}
	}

}

// MARK: - Configuration
extension RepoTableViewCell {
	private func configure() {
		lblName.text = viewModel.name
		lblOwnerName.text = "Owner: \(viewModel.ownerName)"
		lblCreatedAt.text = "\(viewModel.createdAt)"

		if let url = URL(string: viewModel.ownerAvatar) {
			imgvAvatar.load(url: url)
		}
	}
}
