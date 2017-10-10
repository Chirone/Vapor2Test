//
//  BasicValidationController.swift
//  App
//
//  Created by Hayden Young on 28/09/2017.
//

import Cocoa
import Vapor
import FluentProvider
import Validation

struct BasicValidationController {
	func addRoutes(to drop: Droplet) {
		
		let validation = drop.grouped("validation")
		
		validation.get("alpha") { request in
			guard let input = request.data["input"]?.string else {
				throw Abort.badRequest
			}
			try input.validated(by: OnlyAlphanumeric())
			
			return "Validated: \(input)"
		}
		
		validation.get("email") { request in
			guard let input = request.data["input"]?.string else {
				throw Abort.badRequest
			}
			try input.validated(by: EmailValidator())
			
			return "Validated: \(input)"
		}
		
		validation.get("in") { request in
			guard let input = request.data["input"]?.string else {
				throw Abort.badRequest
			}
			let validNames = ["cat", "bird", "fish"]
			try input.validated(by: In(validNames))
			
			return "Validated: \(input)"
		}
		
		validation.get("count") { request in
			guard let input = request.data["input"]?.string,
				let int = Int(input) else {
					throw Abort.badRequest
			}
			
			try int.validated(by: Count.min(1))
			try int.validated(by: Count.max(100))
			try int.validated(by: Count.containedIn(low: 40, high: 60))
			try int.validated(by: Count.equals(50))
			
			return "Validated: \(int)"
		}
		
	}
}
