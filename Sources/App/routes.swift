import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.group("api") { api in
        // Authentication
        try! api.register(collection: AuthenticationController())
        try! api.register(collection: IncomeController())
        try! api.register(collection: SpendingMethodController())
        try! api.register(collection: ExpenseTypeController())
    }
}
