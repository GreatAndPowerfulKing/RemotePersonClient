//
//  RemotePersonViewController.swift
//  RemotePerson
//
//  Created by iKing on 13.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import UIKit

class RemotePersonViewController: UIViewController {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var birthDateLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!

	let url = URL(string: "http://127.0.0.1/person")!
	
	var person: Person? {
		didSet {
			nameLabel.text = person?.name
			var dateText = ""
			if let date = person?.birthDate {
				dateText = "\(date.formated(with: "dd.MM.yyyy"))"
			}
			birthDateLabel.text = dateText
			imageView.image = person?.image
		}
	}
	
	@IBAction func load() {
		person = nil
		spinner.startAnimating()
		
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			
			defer {
				DispatchQueue.main.async {
					self?.spinner.stopAnimating()
				}
			}
			
			guard error == nil, let data = data else {
				DispatchQueue.main.async {
					self?.showError(message: "Error occured while loading data.")
				}
				return
			}
			
			guard let jsonObject = try? JSONSerialization.jsonObject(with: data),
			      let json = jsonObject as? [String: Any],
			      let person = Person(json: json) else {
					
				DispatchQueue.main.async {
					self?.showError(message: "No valid JSON data.")
				}
				return
			}
			
			DispatchQueue.main.async {
				self?.person = person
			}
			
		}.resume()
	}
	
	func showError(message: String) {
		let alert = UIAlertController(title: "Something gone wrong!", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .cancel))
		present(alert, animated: true)
	}
	
}
