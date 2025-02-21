//
//  ExpenseTypeSeeder.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Vapor
import Fluent

struct ExpenseTypeSeeder {
    static func seed(on database: Database) -> EventLoopFuture<Void> {
        
        // Fetch the spending methods from the database
        return SpendingMethod.query(on: database).all().flatMap { spendingMethods in
            // Make sure there are spending methods available
            guard !spendingMethods.isEmpty else {
                return database.eventLoop.makeFailedFuture(Abort(.badRequest, reason: "No spending methods available"))
            }
            var expenseTypes:[ExpenseType] = []
            
            for val in spendingMethods {
                if val.method == "50/30/20" {
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Need" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Need",value: 50 ,spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Wants" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Wants",value: 30 ,spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Saving/Investment" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Saving/Investment",value: 20, spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                }
                
                if val.method == "40/30/20/10" {
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Need" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Need", value:40, spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Wants" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Wants", value:30, spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Saving/Investment" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Saving/Investment", value:20, spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                    if !expenseTypes.contains(where: { $0.id == val.id && $0.description == "Zakat" }) {
                        expenseTypes.append(
                            ExpenseType(description: "Zakat", value:10,  spendingMethodID: val.id!, createdAt: Date(), updatedAt: Date())
                        )
                    }
                }
            }
            return expenseTypes.create(on: database)
        }
    }
}
