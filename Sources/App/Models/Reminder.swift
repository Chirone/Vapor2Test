//
//  Reminder.swift
//  App
//
//  Created by Hayden Young on 27/09/2017.
//

import FluentProvider
import Cocoa

private enum ColumnName: String {
	case title = "title"
	case details = "details"
}

final class Reminder: Model {
	let storage = Storage()
	
	let title: String
	let details: String
	
	init(title: String, details: String) {
		self.title = title
		self.details = details
	}
	
	init(row: Row) throws {
		title = try row.get(ColumnName.title.rawValue)
		details = try row.get(ColumnName.details.rawValue)
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set(ColumnName.title.rawValue, title)
		try row.set(ColumnName.details.rawValue, details)
		return row
	}
}

extension Reminder: Preparation {
	static func prepare(_ database: Database) throws {
		try database.create(self) { builder in
			builder.id()
			builder.string(ColumnName.title.rawValue)
			builder.string(ColumnName.details.rawValue)
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}

extension Reminder: JSONConvertible {
	convenience init(json: JSON) throws {
		try self.init(title: json.get(ColumnName.title.rawValue), details: json.get(ColumnName.details.rawValue))
	}
	
	func makeJSON() throws -> JSON {
		var json = JSON()
		try json.set("id", id)
		try json.set(ColumnName.title.rawValue, title)
		try json.set(ColumnName.details.rawValue, details)
		return json
	}
}

extension Reminder: ResponseRepresentable {}
