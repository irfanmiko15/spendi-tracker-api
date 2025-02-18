//
//  IncomeUserMigration.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//
import Fluent

struct CreateIncomeUserMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_income")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("spending_method_id", .uuid, .required, .references("spending_method", "id", onDelete: .cascade))
            .field("month", .int ,.required)
            .field("amount", .double ,.required)
            .field("year", .int ,.required)
            .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_income").delete()
    }
}
