//
//  ExpenseRepository.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor
import Fluent

protocol ExpenseRepository: Repository {
    func create(_ expense: Expense) -> EventLoopFuture<Void>
    func update(_ expense: Expense) -> EventLoopFuture<Void>
    func delete(id: UUID) -> EventLoopFuture<Void>
    func all(incomeId: UUID) -> EventLoopFuture<[Expense]>
    func find(id: UUID?) -> EventLoopFuture<Expense?>
    func count() -> EventLoopFuture<Int>
}

struct DatabaseExpenseRepository: ExpenseRepository, DatabaseRepository {
    let database: Database
    
    func create(_ expense: Expense) -> EventLoopFuture<Void> {
        return expense.create(on: database)
    }
    
    func delete(id: UUID) -> EventLoopFuture<Void> {
        return Expense.query(on: database)
            .filter(\.$id == id)
            .delete()
    }
    func update(_ expense: Expense) -> EventLoopFuture<Void> {
        return expense.save(on: database)
    }
    
    func all(incomeId: UUID) -> EventLoopFuture<[Expense]> {
        return Expense.query(on: database)
            .with(\.$income).with(\.$expenseType).filter(\.$income.$id == incomeId ).sort(\.$transactionDate, .descending).all()
    }
    
    func find(id: UUID?) -> EventLoopFuture<Expense?> {
        return Expense.find(id, on: database)
    }
    
    func count() -> EventLoopFuture<Int> {
        return Expense.query(on: database).count()
    }
}

extension Application.Repositories {
    var expenses: ExpenseRepository {
        guard let storage = storage.makeExpenseRepository else {
            fatalError("ExpenseRepository not configured, use: app.expenseRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (ExpenseRepository)) {
        storage.makeExpenseRepository = make
    }
}
