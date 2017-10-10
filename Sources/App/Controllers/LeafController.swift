//
//  LeafController.swift
//  App
//
//  Created by Hayden Young on 28/09/2017.
//

import Cocoa
import Vapor
import FluentProvider

class LeafController {

	private var drop: Droplet?
	
	func addRoutes(to drop: Droplet) {
		self.drop = drop
		drop.get("template1", handler: getTemplate1)
	}
	
	func getTemplate1(_ request: Request) throws -> ResponseRepresentable {
		guard let drop = self.drop else {
			throw Abort.badRequest
		}
//		return try self.view.make("hello.leaf", ["name": "Ray"])
		let users = [["name": "Ray"], ["name": "Vicki"], ["name": "Brian"]]
		return try drop.view.make("hello.leaf", ["users": users])
	}
	
}
