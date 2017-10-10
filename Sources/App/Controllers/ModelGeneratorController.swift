//
//  ModelGeneratorController.swift
//  App
//
//  Created by Hayden Young on 10/10/2017.
//

import Cocoa
import Vapor

class ModelGeneratorController {
	
	private var drop: Droplet?
	
	func addRoutes(to drop: Droplet) {
		self.drop = drop
		let group = drop.grouped("model")
		group.get("create", handler: getModelCode)
		group.post("create", handler: postModelCode)
	}
	
	func getModelCode(_ request: Request) throws -> ResponseRepresentable {
		guard let drop = drop else {
			throw Abort.badRequest
		}
		
		return try drop.view.make("createmodel.leaf")
	}
	
	func postModelCode(_ request: Request) throws -> ResponseRepresentable {
		guard let drop = drop,
			let input = request.data["name"]?.string else {
				throw Abort.badRequest
		}
		
		return "the name is \(input)"
	}
}
