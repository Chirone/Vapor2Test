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
		
		guard let variableNames = request.formURLEncoded?["variable_names"]?.array?.flatMap({ $0.string }),
			let jsonKeys = request.formURLEncoded?["json_keys"]?.array?.flatMap({ $0.string }) else {
				throw Abort.badRequest
		}
		
		// Enum
		var code = "private enum ColumnName: String {\n"
		for (variableName, jsonKey) in zip(variableNames, jsonKeys) {
			code += "\tcase \(variableName) = \"\(jsonKey)\"\n"
		}
		code += "}"
		
		return "code is \n\(code)"
	}
}
