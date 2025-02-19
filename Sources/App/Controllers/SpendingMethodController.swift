//
//  SpendingMethodController.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor

struct SpendingMethodController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.group("spending-method") { income in
            // Authentication required
            income.group(UserAuthenticator()) { authenticated in
                authenticated.get(use: getAll)
                authenticated.post(use: createSpendingMethod)
                authenticated.put(":id", use: updateSpendingMethod)
                authenticated.delete(":id", use: deleteSpendingMethod)
            }
        }
    }
    
    private func getAll(_ req: Request) throws -> EventLoopFuture<[SpendingMethodResponse]>{
        let payload = try req.auth.require(Payload.self)
        
        return req.spendingMethod.all() // Return the future directly
                .map { incomes in incomes.map { SpendingMethodResponse(from: $0) } }
        
    }
    
    private func createSpendingMethod(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        do {
            let spendingMethodRequest = try req.content.decode(SpendingMethodRequest.self)
            let spendingMethod = SpendingMethod(
                method: spendingMethodRequest.method
            )
            return req.spendingMethod.create(spendingMethod).transform(to: .created)
        } catch {
            return req.eventLoop.makeFailedFuture(error)  // Proper error handling
        }
    }
    
    private func updateSpendingMethod(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let spendingMethod = SpendingMethod.find(req.parameters.get("id"), on: req.db)
        
        let updatedSpendingMethod = try req.content.decode(SpendingMethodRequest.self)
       
        return spendingMethod
            .unwrap(or: Abort(.notFound, reason: "Spending Method not found"))
            .flatMap { method in
                method.updatedAt = Date()
                method.method = updatedSpendingMethod.method
                
                return req.spendingMethod.update(method).transform(to: .noContent)
            }
    }
    private func deleteSpendingMethod(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        
        let spendingMethod = SpendingMethod.find(req.parameters.get("id"), on: req.db)
        
        return spendingMethod
            .unwrap(or: Abort(.notFound, reason: "Spending Method not found"))
            .flatMap { method in
                return req.spendingMethod.delete(id: method.id ?? UUID()).transform(to: .ok)
            }
    }
}
