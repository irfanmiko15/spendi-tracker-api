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
            .field("spending_method_id", .uuid ,.required)
            .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .foreignKey("spending_method_id", references: "spending_method","id", onDelete: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("expense_type").delete()
    }
}
