//
//  CollectionProtocol.swift
//  Avatars
//
//  Created by Robin Malhotra on 24/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import AsyncDisplayKit
import RxSwift

protocol Collectionable {
	var onlineObservers: [Int: PublishSubject<OnlineState>] { get set }
	var subscriptionCounter: SubscriptionReferenceCounter { get }
	var avatarStubs: [AvatarStub] { get }
	
	func node(for indexPath: IndexPath) -> ASCellNode
}

protocol Reloadable {
	func reloadData()
}

extension ASTableNode: Reloadable { }
extension ASCollectionNode: Reloadable { }

class AvatarSimulatedDataSource: NSObject, Collectionable, ASTableDataSource, ASCollectionDataSource {
	
	var view: Reloadable?
	
	var sizeClassToDisplay: AvatarSizeClass = .large {
		didSet {
			self.view?.reloadData()
		}
	}
	
	var onlineObservers: [Int: PublishSubject<OnlineState>] = [:]
	let subscriptionCounter = SubscriptionReferenceCounter()
	let avatarStubs: [AvatarStub] = {
		return (globalAvatarStore.reduce([], { (arr, pair) -> [AvatarStub] in
			
			let (key, value) = pair
			return arr + [value]
		}) * 10).shuffled()
	}()
	
	func node(for indexPath: IndexPath) -> ASCellNode {
		let avatar: Avatar = .url(avatarStubs[indexPath.row].url)
		let id = avatarStubs[indexPath.row].id
		let subscription = onlineObservers[indexPath.row]
		
		return AvatarNode(avatar, initials: avatarStubs[indexPath.row].initials , sizeClass: sizeClassToDisplay, id: id, onlineSubscription: subscription, subscriptionCounter: self.subscriptionCounter)
	}
	
	override init() {
		super.init()
	}
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}
	
	func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
		return 1
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return avatarStubs.count
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
		return avatarStubs.count
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		return node(for: indexPath)
	}
	
	func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
		return node(for: indexPath)
	}
}
