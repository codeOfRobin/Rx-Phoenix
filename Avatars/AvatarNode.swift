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
	
	var preferredEdgeLength: CGFloat {
		get {
			switch self {
			case .large:
				return 52
			case .medium:
				return 42
			case .small:
				return 11
			case .micro:
				return 9
			}
		}
	}
	
	var preferredCornerRadius: CGFloat {
		get {
			return 3.0
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
	
	init(_ avatar: Avatar, sizeClass: AvatarSizeClass) {
		super.init()
		self.automaticallyManagesSubnodes = true
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
		return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4), child: stack)
	}
	
	override func nodeDidLayout() {
		switch imageNode.frame.width {
		case 0..<12:
			//set frame of online indicator here
			break
		default:
			//other cases
			break
		}
	}
	
	override func didEnterDisplayState() {
		print("entered")
	}
	
	override func didExitHierarchy() {
		print("exited")
	}
}


