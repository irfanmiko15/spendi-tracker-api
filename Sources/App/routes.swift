import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get("verify-status",":status") { req -> EventLoopFuture<View> in
        guard let status = req.parameters.get("status") else {
                throw Abort(.badRequest, reason: "Missing status parameter.")
            }
        return req.view.render("emailVerified", ["status": status])
    }
    
    app.group("api") { api in
        // Authentication
        try! api.register(collection: AuthenticationController())
        try! api.register(collection: IncomeController())
        try! api.register(collection: SpendingMethodController())
        try! api.register(collection: ExpenseTypeController())
        try! api.register(collection: ExpenseController())
    }
}
