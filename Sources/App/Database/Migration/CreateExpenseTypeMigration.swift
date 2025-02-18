//
//  CreateExpenseTypeMigration.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//


import Fluent

struct CreateExpenseTypeMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("expense_type")
            .id()
            .field("description", .string, .required)
            .field("value", .int, .required)
            .field("spending_method_id", .uuid ,.required, .references("spending_method","id", onDelete: .cascade))
            .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("expense_type").delete()
    }
}
