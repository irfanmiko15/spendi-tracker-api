//
//  CrateUserTableMigration.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Fluent

struct CrateUserMigration : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database.schema("users")
                .id()
                .field("first_name", .string, .required)
                .field("last_name", .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .field("is_email_verified", .bool, .required, .custom("DEFAULT FALSE"))
                .field("created_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
                .field("updated_at", .datetime, .required, .custom("DEFAULT CURRENT_TIMESTAMP"))
                .unique(on: "email")
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database.schema("users").delete()
        }
}
