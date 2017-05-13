//
//  Person.swift
//  RemotePersone
//
//  Created by iKing on 13.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import UIKit

struct Person {
	
	var name: String
	var birthDate: Date?
	var image: UIImage?
	
	init?(json: [String: Any]) {
		guard let name = json["name"] as? String else {
			return nil
		}
		self.name = name
		
		if let birthDate = json["birthDate"] as? String {
			self.birthDate = Date.fromString(birthDate, format: "dd.MM.yyyy")
		}
		
		if let imageString = json["image"] as? String, let data = Data(base64Encoded: imageString) {
			self.image = UIImage(data: data)
		}
	}
	
}
