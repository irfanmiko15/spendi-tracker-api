//
//  CreateRefreshTokenMigration.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Fluent

struct CreateRefreshTokenMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_refresh_tokens")
            .id()
            .field("token", .string)
            .field("user_id", .uuid, .references("users", "id", onDelete: .cascade))
            .field("expires_at", .datetime)
            .field("issued_at", .datetime)
            .unique(on: "token")
            .unique(on: "user_id")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_refresh_tokens").delete()
    }
}
