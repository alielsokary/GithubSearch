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
		setupUI()
    }

	private func setupUI() {
		lblName.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		lblOwnerName.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblCreatedAt.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
		lblName.textColor = UIColor.red.withAlphaComponent(0.5)
		lblCreatedAt.textColor = UIColor.blue.withAlphaComponent(0.5)

	}

	func setTitle(_ title: String) {
		lblName.text = title
	}

	func setOwnerName(_ owenerName: String) {
		lblOwnerName.text = "Owner: \(owenerName)"
	}

	func setOwnerAvatar(_ avatarUrl: String) {
		if let url = URL(string: avatarUrl) {
			imgvAvatar.load(url: url)
		}
	}

	func setDate(_ date: String) {
		lblCreatedAt.text = "\(date)"
	}

}
