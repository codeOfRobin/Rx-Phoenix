//
//  VisibilitySubscription.swift
//  Avatars
//
//  Created by Robin Malhotra on 24/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation
import RxSwift

class VisibilitySubscription {
	var visibleIDs = Set<Int>()
	
	let enterSubscription = PublishSubject<Int>()
}
