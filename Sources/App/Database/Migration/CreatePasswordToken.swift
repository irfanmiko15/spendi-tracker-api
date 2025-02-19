//
//  CreatePasswordToken.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//


import Fluent

struct CreatePasswordTokenMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("user_password_tokens")
            .id()
            .field("user_id", .uuid, .required)
            .field("token", .string, .required)
            .field("expires_at", .datetime, .required)
            .foreignKey("user_id", references: "users", "id",onDelete: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("user_password_tokens").delete()
    }
}
