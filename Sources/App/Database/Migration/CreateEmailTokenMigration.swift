import Fluent

struct CreateEmailTokenMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_email_tokens")
            .id()
            .field("user_id", .uuid, .required)
            .field("token", .string, .required)
            .field("expires_at", .datetime, .required)
            .foreignKey("user_id", references: "users", "id", onDelete: .cascade)
            .unique(on: "user_id")
            .unique(on: "token")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_email_tokens").delete()
    }
}
