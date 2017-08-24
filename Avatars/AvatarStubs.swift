//
//  AvatarStubs.swift
//  Avatars
//
//  Created by Robin Malhotra on 23/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation

struct AvatarStub {
	let id: Int
	let url: URL
	let initials: String
}


let globalAvatarStore: [Int: AvatarStub] = {
	let avatarStubs: [URL] = ["https://kayako-mobile-testing.kayako.com/avatar/get/4ab8da0f-74f1-55f8-ae68-6925a1ac3a2c?1503057670",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/a834f117-6a98-5308-9cbd-807f31b5a752?1503044482",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/7c2ca881-6531-5175-82ea-f0912029a46c?1502943729",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/bced0c8c-c6ff-5bfd-86c3-a821c03a692c?1502211009",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/ea66d80e-0eb8-53d1-ad29-50e22e82ffbc?1501904579",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/4d97fa3f-09f0-5038-9913-7641f0f3a299?1501747572",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/af802f98-1b0e-510e-8144-8f857acccbbc?1501727450",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/55a573d8-ec77-5fca-81b3-47d403a644cd?1501677632",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/d8ec3868-a47c-5b91-9af5-bd47087c365c?1501675372",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/5bc85efd-e909-596f-b72d-e0556f3c19a1?1501670071",
	  "https://kayako-mobile-testing.kayako.com/avatar/get/1f730365-ab37-50ca-8c0a-1d39de36416d?1501669117"
		]
	
	let initials = [
		"N-brown", "B-purple", "B-brown", "G-purple", "LK-blue", "T-brown", "TC-purple", "SS-green", "BG-purple", "PR-purple", "GI-blue"
	]
	
	return zip(initials, avatarStubs)
		.enumerated()
		.map{
			AvatarStub.init(id: $0, url: $1.1, initials: $1.0)
		}
		.reduce([:], { (dict, stub) -> [Int: AvatarStub] in
			var copy = dict
			copy[stub.id] = stub
			return copy
		})
	
}()
