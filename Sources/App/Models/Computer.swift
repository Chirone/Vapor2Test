//
//  Computer.swift
//  App
//
//  Created by Hayden Young on 10/10/2017.
//

import Cocoa
import FluentProvider

private enum ColumnName: String {
	case title
	case details
}

final class Computer: Model {

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

extension Computer: Preparation {
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

extension Computer: JSONConvertible {
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

extension Computer: ResponseRepresentable {}
