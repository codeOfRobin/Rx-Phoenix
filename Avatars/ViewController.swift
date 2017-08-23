//
//  ViewController.swift
//  Avatars
//
//  Created by Robin Malhotra on 22/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import UIKit
import RxSwift
import Birdsong
import AsyncDisplayKit


class ViewController: UIViewController, ASTableDataSource, ASTableDelegate {

	let tableNode = ASTableNode()
	
	var sizeClassToDisplay: AvatarSizeClass = .large {
		didSet {
			self.tableNode.reloadData()
		}
	}
	
	var onlineObservers: [Int: PublishSubject<Bool>] = [:]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableNode.dataSource = self
		self.view.addSubnode(tableNode)
		tableNode.view.separatorStyle = .none
		
		tableNode.leadingScreensForBatching = 2.0
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
		return AvatarNode(.url(avatarStubs[indexPath.row]!.url), sizeClass: sizeClassToDisplay)
	}
	
	func numberOfSections(in tableNode: ASTableNode) -> Int {
		return 1
	}
	
	func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
		return avatarStubs.count
	}
	
	override func viewDidLayoutSubviews() {
		tableNode.frame = view.frame
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	override var keyCommands: [UIKeyCommand]? {
		return [
			UIKeyCommand(input: "1", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "micro"),
			UIKeyCommand(input: "2", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "small"),
			UIKeyCommand(input: "3", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "medium"),
			UIKeyCommand(input: "4", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "large"),
		]
		
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	func selectTab(sender: UIKeyCommand) {
		let selectedTab = sender.input
		print(selectedTab)
		let sizeClass: AvatarSizeClass = {
			guard let selected = Int(selectedTab) else {
				fatalError()
			}
			switch selected {
			case 1:
				return .micro
			case 2:
				return .small
			case 3:
				return .medium
			case 4:
				return .large
			default:
				return .large
			}
		}()
		
		self.sizeClassToDisplay = sizeClass
	}
	
}

