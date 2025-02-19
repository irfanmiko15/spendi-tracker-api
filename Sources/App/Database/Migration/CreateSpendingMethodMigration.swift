//
//  CreateSpendingMethodMigration.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//


import Fluent

struct CreateSpendingMethodTypeMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("spending_method")
            .id()
            .field("method", .string, .required)
            .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
            .create()
        
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("spending_method").delete()
    }
}
