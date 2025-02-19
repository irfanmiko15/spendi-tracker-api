//
//  ExpenseTypeController.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//


import Vapor

struct ExpenseTypeController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.group("expense-type") { expense in
            // Authentication required
            expense.group(UserAuthenticator()) { authenticated in
                authenticated.get(use: getAll)
                authenticated.post(use: createExpenseType)
                authenticated.put(":id", use: updateExpenseType)
                authenticated.delete(":id", use: deleteExpenseType)
            }
        }
    }
    
    private func getAll(_ req: Request) throws -> EventLoopFuture<[ExpenseTypeResponse]>{
        let payload = try req.auth.require(Payload.self)
        let spendingMethodId = req.query[UUID.self, at: "spendingMethodId"]
        return req.expenseType.all(spendingMethodId: spendingMethodId) // Return the future directly
            .map { incomes in incomes.map { ExpenseTypeResponse(from: $0) } }
        
    }
    
    private func createExpenseType(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        do {
            let expenseTypeRequest = try req.content.decode(ExpenseTypeRequest.self)
            let expenseType = ExpenseType(description: expenseTypeRequest.description, value: expenseTypeRequest.value, spendingMethodID: expenseTypeRequest.spendingMethodId, createdAt: Date(), updatedAt: Date())
            return req.expenseType.create(expenseType).transform(to: .created)
        } catch {
            return req.eventLoop.makeFailedFuture(error)  // Proper error handling
        }
    }
    
    private func updateExpenseType(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let expenseType = ExpenseType.find(req.parameters.get("id"), on: req.db)
        
        let updatedExpenseType = try req.content.decode(ExpenseTypeRequest.self)
       
        return expenseType
            .unwrap(or: Abort(.notFound, reason: "Expense Type not found"))
            .flatMap { expense in
                
                expense.description = updatedExpenseType.description
                expense.$spendingMethod.id = updatedExpenseType.spendingMethodId
                expense.value = updatedExpenseType.value
                expense.updatedAt = Date()
                
                
                return req.expenseType.update(expense).transform(to: .noContent)
            }
    }
    private func deleteExpenseType(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let expenseType = ExpenseType.find(req.parameters.get("id"), on: req.db)
        
        return expenseType
            .unwrap(or: Abort(.notFound, reason: "Spending Method not found"))
            .flatMap { method in
                return req.expenseType.delete(id: method.id ?? UUID()).transform(to: .ok)
            }
    }
}
