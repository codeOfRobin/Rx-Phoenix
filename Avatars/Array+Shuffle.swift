//
//  Array+Shuffle.swift
//  Avatars
//
//  Created by Robin Malhotra on 23/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation

extension Sequence {
	/// Returns an array with the contents of this sequence, shuffled.
	func shuffled() -> [Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}

}

func *<T>(left: Array<T>, right: Int) -> Array<T> {
	return Array((0..<right).map {
		_ in
		return left
	}.joined())
}


extension MutableCollection {
	/// Shuffles the contents of this collection.
	mutating func shuffle() {
		let c = count
		guard c > 1 else { return }
		
		for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
			let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
			let i = index(firstUnshuffled, offsetBy: d)
			swapAt(firstUnshuffled, i)
		}
	}
}
