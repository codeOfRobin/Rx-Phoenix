//
//  Bool+Random.swift
//  Avatars
//
//  Created by Robin Malhotra on 24/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation

extension Bool {
	static func random() -> Bool {
		return arc4random_uniform(2) == 0
	}
}
