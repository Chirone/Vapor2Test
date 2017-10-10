//
//  RemindersController.swift
//  App
//
//  Created by Hayden Young on 27/09/2017.
//

import Cocoa
import Vapor
import FluentProvider

struct RemindersController {//: ResourceRepresentable {
//	func makeResource() -> Resource<Reminder> {
// 		return Resource(index: <#T##Resource.Multiple?##Resource.Multiple?##(Request) throws -> ResponseRepresentable#>,
// 		                create: <#T##Resource.Multiple?##Resource.Multiple?##(Request) throws -> ResponseRepresentable#>,
// 		                store: <#T##Resource.Multiple?##Resource.Multiple?##(Request) throws -> ResponseRepresentable#>,
// 		                show: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                edit: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                update: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                replace: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                destroy: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                clear: <#T##Resource.Multiple?##Resource.Multiple?##(Request) throws -> ResponseRepresentable#>,
// 		                aboutItem: <#T##((Request, _) throws -> ResponseRepresentable)?##((Request, _) throws -> ResponseRepresentable)?##(Request, _) throws -> ResponseRepresentable#>,
// 		                aboutMultiple: <#T##Resource.Multiple?##Resource.Multiple?##(Request) throws -> ResponseRepresentable#>)
//	}

	func addRoutes(to drop: Droplet) {
		let reminderGroup = drop.grouped("api", "reminders")
		reminderGroup.post("create", handler: createReminder)
		reminderGroup.get(handler: allReminders)
		reminderGroup.get(Reminder.parameter, handler: getReminder)
		reminderGroup.get("allLists", handler: getLists)
		reminderGroup.delete(Reminder.parameter, handler: deleteReminder)
	}
	
	func createReminder(_ request: Request) throws -> ResponseRepresentable {
		guard let json = request.json else {
			throw Abort.badRequest
		}
		let reminder = try Reminder(json: json)
		try reminder.save()
		
		return reminder
	}
	
	func allReminders(_ request: Request) throws -> ResponseRepresentable {
		let reminders = try Reminder.all()
		
		return try reminders.makeJSON()
	}
	
	func getReminder(_ request: Request) throws -> ResponseRepresentable {
		let reminder = try request.parameters.next(Reminder.self)
		
		return reminder
	}

	func getLists(_ request: Request) throws -> ResponseRepresentable {
		return try Reminder.makeQuery().filter("title", .contains, "List").all().makeJSON()
	}
	
	func deleteReminder(_ request: Request) throws -> ResponseRepresentable {
		let reminder = try request.parameters.next(Reminder.self)
		try reminder.delete()
		
		return reminder
	}
}
