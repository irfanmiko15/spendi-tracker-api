//
//  IncomeRepository.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor
import Fluent

protocol IncomeRepository: Repository {
    func create(_ income: Income) -> EventLoopFuture<Void>
    func update(_ income: Income) -> EventLoopFuture<Void>
    func delete(id: UUID) -> EventLoopFuture<Void>
    func all(userId: UUID) -> EventLoopFuture<[Income]>
    func find(id: UUID?) -> EventLoopFuture<Income?>
    func count() -> EventLoopFuture<Int>
}

struct DatabaseIncomeRepository: IncomeRepository, DatabaseRepository {
    let database: Database
    
    func create(_ income: Income) -> EventLoopFuture<Void> {
        return income.create(on: database)
    }
    
    func delete(id: UUID) -> EventLoopFuture<Void> {
        return Income.query(on: database)
            .filter(\.$id == id)
            .delete()
    }
    func update(_ income: Income) -> EventLoopFuture<Void> {
        return income.save(on: database)
    }
    
    func all(userId: UUID) -> EventLoopFuture<[Income]> {
        return Income.query(on: database)
            .with(\.$spendingMethod).filter(\.$user.$id == userId ).sort(\.$createdAt, .descending).all()
    }
    
    func find(id: UUID?) -> EventLoopFuture<Income?> {
        return Income.find(id, on: database)
    }
    
    func count() -> EventLoopFuture<Int> {
        return Income.query(on: database).count()
    }
}

extension Application.Repositories {
    var incomes: IncomeRepository {
        guard let storage = storage.makeIncomeRepository else {
            fatalError("IncomeRepository not configured, use: app.incomeRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (IncomeRepository)) {
        storage.makeIncomeRepository = make
    }
}
