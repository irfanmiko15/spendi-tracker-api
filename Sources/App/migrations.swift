import Vapor

func migrations(_ app: Application) throws {
    // Initial Migrations
    app.migrations.add(CrateUserMigration())
    app.migrations.add(CreateRefreshTokenMigration())
    app.migrations.add(CreateEmailTokenMigration())
    app.migrations.add(CreatePasswordTokenMigration())
    app.migrations.add(CreateSpendingMethodTypeMigration())
    app.migrations.add(CreateExpenseTypeMigration())
    app.migrations.add(CreateIncomeUserMigration())
    app.migrations.add(CreateExpenseUserMigration())
}
