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

enum OnlineState {
	case offline
	case online
}

class ViewController: UIViewController {

	let tableNode = ASTableNode()
	
	let disposeBag = DisposeBag()
	
	var dataSource = AvatarSimulatedDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableNode.dataSource = dataSource
		self.view.addSubnode(tableNode)
		tableNode.view.separatorStyle = .none
		
		tableNode.leadingScreensForBatching = 2.0
		
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (_) in
			guard let subjects = self?.dataSource.onlineObservers else {
				return
			}
			for (_, subject) in subjects {
				subject.onNext(Bool.random() == false ? .offline : .online)
			}
		}
		
		self.dataSource.subscriptionCounter.subscriptionBroadcast.debounce(3, scheduler: MainScheduler()).single().subscribe(onNext: { [weak self] (ids) in
			for id in ids {
				self?.dataSource.onlineObservers[id] = PublishSubject<OnlineState>()
			}
			self?.tableNode.reloadData()
		}, onDisposed: {
			print("disposed")
		}).disposed(by: disposeBag)
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidLayoutSubviews() {
		tableNode.frame = view.frame
	}

	override var keyCommands: [UIKeyCommand]? {
		return [
			UIKeyCommand(input: "1", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "nano"),
			UIKeyCommand(input: "2", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "micro"),
			UIKeyCommand(input: "3", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "small"),
			UIKeyCommand(input: "4", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "medium"),
			UIKeyCommand(input: "5", modifierFlags: [], action: #selector(selectTab(sender:)), discoverabilityTitle: "large"),
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
				return .nano
			case 2:
				return .micro
			case 3:
				return .small
			case 4:
				return .medium
			case 5:
				return .large
			default:
				return .large
			}
		}()
		
		self.dataSource.sizeClassToDisplay = sizeClass
	}
	
	deinit {
		print("deinited")
	}
	
}

