import Vapor

import VaporValidation
import PostgreSQLProvider

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
		
		let basicValidationController = BasicValidationController()
		basicValidationController.addRoutes(to: self)
		
		let leafController = LeafController()
		leafController.addRoutes(to: self)
		
		let modelGeneratorController = ModelGeneratorController()
		modelGeneratorController.addRoutes(to: self)
		
		get("version") { request in
			let db = try self.postgresql()
			let version = try db.raw("SELECT version()")
			return JSON(node: version)
		}
		
		let remindersController = RemindersController()
		remindersController.addRoutes(to: self)
		
		
//        try resource("posts", PostController.self)
    }
	
}

