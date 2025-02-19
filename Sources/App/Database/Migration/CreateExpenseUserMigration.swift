//
//  Untitled.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Fluent

struct CreateExpenseUserMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_expense")
            .id()
            .field("income_id", .uuid ,.required)
            .field("expense_type_id", .uuid ,.required)
            .field("description", .string)
            .field("amount", .double)
            .field("transaction_date", .datetime, .required)
            .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .foreignKey("income_id", references: "user_income", "id",onDelete: .cascade)
            .foreignKey("expense_type_id", references: "expense_type", "id",onDelete: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_expense").delete()
    }
}
