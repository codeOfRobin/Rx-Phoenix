//
//  CollectionProtocol.swift
//  Avatars
//
//  Created by Robin Malhotra on 24/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit

protocol CollectionAble {
	func node(for indexPath: IndexPath) -> ASCellNode
	func rows() -> Int
}

class AvatarSimulatedDataSource {
	init() {
		
	}
}
