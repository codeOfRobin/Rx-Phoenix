//
//  URL+StringExpressible.swift
//  Avatars
//
//  Created by Robin Malhotra on 23/08/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
	public typealias StringLiteralType = String
	
	public init(stringLiteral value: URL.StringLiteralType) {
		self = URL(string: value)!
	}
	
}
