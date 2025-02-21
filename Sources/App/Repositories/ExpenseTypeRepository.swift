//
//  ExpenseTypeRepository.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//


import Vapor
import Fluent

protocol ExpenseTypeRepository: Repository {
    func create(_ expenseType: ExpenseType) -> EventLoopFuture<Void>
    func update(_ expenseType: ExpenseType) -> EventLoopFuture<Void>
    func delete(id: UUID) -> EventLoopFuture<Void>
    func all(spendingMethodId: UUID?) -> EventLoopFuture<[ExpenseType]>
    func find(id: UUID?) -> EventLoopFuture<ExpenseType?>
    func count() -> EventLoopFuture<Int>
}

struct DatabaseExpenseTypeRepository: ExpenseTypeRepository, DatabaseRepository {
    let database: Database
    
    func create(_ expenseType: ExpenseType) -> EventLoopFuture<Void> {
        return expenseType.create(on: database)
    }
    
    func delete(id: UUID) -> EventLoopFuture<Void> {
        return ExpenseType.query(on: database)
            .filter(\.$id == id)
            .delete()
    }
    func update(_ expenseType: ExpenseType) -> EventLoopFuture<Void> {
        return expenseType.save(on: database)
    }
    
    func all(spendingMethodId: UUID?) -> EventLoopFuture<[ExpenseType]> {
        
        var query = ExpenseType.query(on: database)
            .with(\.$spendingMethod).sort(\.$value, .descending)
        
        if let spendingMethodId = spendingMethodId {
            query = query.filter(\.$spendingMethod.$id == spendingMethodId)
        }
            
        return query.all()
    }
    
    func find(id: UUID?) -> EventLoopFuture<ExpenseType?> {
        return ExpenseType.find(id, on: database)
    }
    
    func count() -> EventLoopFuture<Int> {
        return ExpenseType.query(on: database).count()
    }
}

extension Application.Repositories {
    var expenseTypes: ExpenseTypeRepository {
        guard let storage = storage.makeExpenseTypeRepository else {
            fatalError("ExpenseTypeRepository not configured, use: app.expenseTypeRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (ExpenseTypeRepository)) {
        storage.makeExpenseTypeRepository = make
    }
}
