//
//  ExpenseController.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor

struct ExpenseController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.group("expense") { expense in
            // Authentication required
            expense.group(UserAuthenticator()) { authenticated in
                authenticated.get(":id",use: getAllExpense)
                authenticated.post(use: createExpense)
                authenticated.put(":id", use: updateExpense)
                authenticated.delete(":id", use: deleteIncome)
            }
        }
    }
    
    private func getAllExpense(_ req: Request) throws -> EventLoopFuture<[ExpenseResponse]>{
        
        guard let incomeIdString = req.parameters.get("id"),
        let incomeId = UUID(uuidString: incomeIdString) else {
                throw Abort(.badRequest, reason: "id must be a valid UUID.")
        }
        return req.expense.all(incomeId: incomeId)
            .map { expense in expense.map { ExpenseResponse(from: $0) } }
        
    }
    
    private func createExpense(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        do {
            let expenseRequest = try req.content.decode(ExpenseRequest.self)
            let payload = try req.auth.require(Payload.self)
            let trxDate = FormatUtils().date(date: expenseRequest.transactionDate)
            let expense = Expense(income: expenseRequest.incomeId,expenseType: expenseRequest.expenseTypeId,description: expenseRequest.description ,amount: expenseRequest.amount, transactionDate: trxDate)

            return req.expense.create(expense).transform(to: .created)
        } catch {
            return req.eventLoop.makeFailedFuture(error)  // Proper error handling
        }
    }
    
    private func updateExpense(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let expense = Expense.find(req.parameters.get("id"), on: req.db)
        
        let updatedExpense = try req.content.decode(ExpenseRequest.self)
        let trxDate = FormatUtils().date(date: updatedExpense.transactionDate)
        return expense
            .unwrap(or: Abort(.notFound, reason: "Expense not found"))
            .flatMap { expenses in
                expenses.updatedAt = Date()
                expenses.description = updatedExpense.description
                expenses.amount = updatedExpense.amount
                expenses.$expenseType.id = updatedExpense.expenseTypeId
                expenses.transactionDate = trxDate
                
                return req.expense.update(expenses).transform(to: .noContent)
            }
    }
    private func deleteIncome(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let expense = Expense.find(req.parameters.get("id"), on: req.db)
        
        return expense
            .unwrap(or: Abort(.notFound, reason: "Expense not found"))
            .flatMap { expenses in
                return req.expense.delete(id: expenses.id ?? UUID()).transform(to: .ok)
            }
    }
}
