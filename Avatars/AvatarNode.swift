//
//  AvatarNode.swift
//  Kayako
//
//  Created by Robin Malhotra on 22/08/17.
//  Copyright © 2017 Kayako. All rights reserved.
//

import AsyncDisplayKit
import RxSwift

enum AvatarSizeClass {
	case large
	case medium
	case small
	case micro
	case nano
	
	var preferredEdgeLength: CGFloat {
		get {
			switch self {
			case .large:
				return 48
			case .medium:
				return 42
			case .small:
				return 24
			case .micro:
				return 18
			case .nano:
				return 16
			}
		}
	}
	
	var preferredOnlineIndicatorSize: CGFloat {
		get {
			switch self {
			case .large:
				return 16
			case .medium:
				return 14
			case .small:
				return 12
			case .micro:
				return 9
			case .nano:
				return 8
			}
		}
	}
}

enum Avatar {
	case image(UIImage)
	case url(URL)
}

class AvatarNode: ASCellNode {
	
	let imageNode = ASNetworkImageNode()
	let onlineNode = ASDisplayNode()
	let initials: String
	
	var sizeClass: AvatarSizeClass
	
	var state: OnlineState = .offline {
		didSet {
			self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
		}
	}
	
	let disposeBag = DisposeBag()
	
	
	init(_ avatar: Avatar, sizeClass: AvatarSizeClass, initials: String, subscription: PublishSubject<OnlineState>? = nil) {
		self.initials = initials
		self.sizeClass = sizeClass
		super.init()
		self.addSubnode(imageNode)
		self.addSubnode(onlineNode)
		onlineNode.backgroundColor = UIColor(red:0.32, green:0.67, blue:0.38, alpha:1.00)
		onlineNode.layer.borderColor = UIColor.white.cgColor
		self.setAvatar(avatar, sizeClass: sizeClass)
		
		if let subscription = subscription {
			subscription.subscribe(onNext: { [weak self] (state) in
				self?.state = state
			}, onDisposed: {
				print("disposed")
			}).disposed(by: disposeBag)
		}
	}
	
	func setAvatar(_ avatar: Avatar, sizeClass: AvatarSizeClass) {
		self.sizeClass = sizeClass
		switch avatar {
		case .image(let image):
			imageNode.image = image
		case .url(let url):
			imageNode.setImageURL(url)
		}
		
		self.imageNode.style.preferredSize = CGSize(width: sizeClass.preferredEdgeLength, height: sizeClass.preferredEdgeLength)
		
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .start, alignItems: .center, children: [imageNode])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10), child: stack)
	}
	
	override func animateLayoutTransition(_ context: ASContextTransitioning) {
		switch self.state {
		case .offline:
			UIView.animate(withDuration: 0.25, animations: {
				[weak self] in
				self?.onlineNode.alpha = 0
			})
		case .online:
			UIView.animate(withDuration: 0.25, animations: {
				[weak self] in
				self?.onlineNode.alpha = 1
			})
		}
	}
	
	override func layoutDidFinish() {
		super.layoutDidFinish()
		onlineNode.layer.cornerRadius = sizeClass.preferredOnlineIndicatorSize/2
		onlineNode.layer.borderWidth = 2.0
		onlineNode.frame = CGRect(x: imageNode.frame.maxX - sizeClass.preferredOnlineIndicatorSize/2, y: imageNode.frame.maxY - sizeClass.preferredOnlineIndicatorSize/2, width: sizeClass.preferredOnlineIndicatorSize, height: sizeClass.preferredOnlineIndicatorSize)
	}
	
	override func didEnterPreloadState() {
		super.didEnterPreloadState()
	}
	
	override func didEnterVisibleState() {
		super.didEnterVisibleState()
		
//		let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] (timer) in
//			if let state = self?.state {
//				switch state {
//				case .offline:
//					self?.state = .online
//				case .online:
//					self?.state = .offline
//				}
//			}
//		}
	}
	
	
	override func didExitHierarchy() {
		super.didExitHierarchy()
		self.state = .offline
	}
}


