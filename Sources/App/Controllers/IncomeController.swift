//
//  IncomeController.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor

struct IncomeController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.group("income") { income in
            // Authentication required
            income.group(UserAuthenticator()) { authenticated in
                authenticated.get(use: getAllIncome)
                authenticated.post(use: createIncome)
                authenticated.put(":id", use: updateIncome)
                authenticated.delete(":id", use: deleteIncome)
            }
        }
    }
    
    private func getAllIncome(_ req: Request) throws -> EventLoopFuture<[IncomeResponse]>{
        let payload = try req.auth.require(Payload.self)
        
        return req.income.all(userId: payload.userID) // Return the future directly
                .map { incomes in incomes.map { IncomeResponse(from: $0) } } 
        
    }
    
    private func createIncome(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        do {
            let incomeRequest = try req.content.decode(IncomeRequest.self)
            let payload = try req.auth.require(Payload.self)

            let income = Income(
                user: payload.userID,  // Ensure this matches your `Income` model
                spendingMethod: incomeRequest.spendingMethodId,
                month: incomeRequest.month,
                year: incomeRequest.year,
                amount: incomeRequest.amount
            )

            return req.income.create(income).transform(to: .created)
        } catch {
            return req.eventLoop.makeFailedFuture(error)  // Proper error handling
        }
    }
    
    private func updateIncome(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let incomeFuture = Income.find(req.parameters.get("id"), on: req.db)
        
        let updatedIncome = try req.content.decode(IncomeRequest.self)
       
        return incomeFuture
            .unwrap(or: Abort(.notFound, reason: "Income not found"))
            .flatMap { income in
                income.amount = updatedIncome.amount
                income.month = updatedIncome.month
                income.year = updatedIncome.year
                income.updatedAt = Date()
                income.$spendingMethod.id = updatedIncome.spendingMethodId
                
                return req.income.update(income).transform(to: .noContent)
            }
    }
    private func deleteIncome(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let income = Income.find(req.parameters.get("id"), on: req.db)
        
        return income
            .unwrap(or: Abort(.notFound, reason: "Income not found"))
            .flatMap { income in
                return req.income.delete(id: income.id ?? UUID()).transform(to: .ok)
            }
    }
}
