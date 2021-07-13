//
//  UIViewController+Extensions.swift
//  GithubSearch
//
//  Created by Ali Elsokary on 13/07/2021.
//  
//

import UIKit

extension UIViewController {

	func showAlert(message: String) {
		let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true)
	}

}
