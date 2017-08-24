//
//  AvatarNode.swift
//  Kayako
//
//  Created by Robin Malhotra on 22/08/17.
//  Copyright © 2017 Kayako. All rights reserved.
//

import AsyncDisplayKit

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
	
	var preferredCornerRadius: CGFloat {
		get {
			switch self {
			case .large:
				return 12
			case .medium:
				return 11
			case .small:
				return 10
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
	
	init(_ avatar: Avatar, sizeClass: AvatarSizeClass, initials: String) {
		self.initials = initials
		super.init()
		self.addSubnode(imageNode)
		self.addSubnode(onlineNode)
		onlineNode.backgroundColor = UIColor(red:0.32, green:0.67, blue:0.38, alpha:1.00)
		onlineNode.layer.cornerRadius = 5.0
		onlineNode.layer.borderWidth = 1.0
		onlineNode.layer.borderColor = UIColor.white.cgColor
		self.setAvatar(avatar, sizeClass: sizeClass)
	}
	
	func setAvatar(_ avatar: Avatar, sizeClass: AvatarSizeClass) {
		
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
		return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5), child: stack)
	}
	
	override func layoutDidFinish() {
		super.layoutDidFinish()
		onlineNode.frame = CGRect(x: imageNode.frame.maxX - 5, y: imageNode.frame.maxY - 5, width: 10, height: 10)
	}
	
	override func didEnterPreloadState() {
		super.didEnterPreloadState()
		print("entered \(initials)")
	}
	
	
	override func didExitHierarchy() {
		super.didExitHierarchy()
		print("exit \(initials)")
	}
}


