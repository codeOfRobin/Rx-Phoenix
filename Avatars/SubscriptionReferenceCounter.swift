//
//  SubscriptionReferenceCounter.swift
//  Avatars
//
//  Created by Robin Malhotra on 24/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation
import RxSwift

// How much does your life have to suck that you're re-implimenting reference counting 😩
class SubscriptionReferenceCounter {
	
	static let shared = SubscriptionReferenceCounter()
	
	private let subscriptionBroadcastSubject = PublishSubject<[Int]>()
	
	var subscriptionBroadcast: Observable<[Int]> {
		get {
			return subscriptionBroadcastSubject.asObservable()
		}
	}
	
	private var dictionary: [Int: Int] = [:] {
		didSet {
			subscriptionBroadcastSubject.onNext(self.ids)
		}
	}
	
	func increment(id: Int) {
		if let value = dictionary[id] {
			dictionary[id] = value + 1
		} else {
			dictionary[id] = 1
		}
	}
	
	func decrement(id: Int) {
		if let value = dictionary[id] {
			if value == 1 {
//				print("subscription destroyed")
				dictionary.removeValue(forKey: id)
			} else {
				dictionary[id] = value - 1
				print("decremented")
			}
		} else {
			//: called if a deinit happens before a cell is preloaded. Popping the view controller, for example
			dictionary.removeValue(forKey: id)
		}
	}
	
	var ids: [Int] {
		get  {
			return Array(dictionary.keys)
		}
	}
	
}
