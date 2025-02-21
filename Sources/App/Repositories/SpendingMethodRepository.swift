//
//  SpendingMethodRepository.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor
import Fluent

protocol SpendingMethodRepository: Repository {
    func create(_ spendingMethod: SpendingMethod) -> EventLoopFuture<Void>
    func update(_ spendingMethod: SpendingMethod) -> EventLoopFuture<Void>
    func delete(id: UUID) -> EventLoopFuture<Void>
    func all() -> EventLoopFuture<[SpendingMethod]>
    func find(id: UUID?) -> EventLoopFuture<SpendingMethod?>
    func count() -> EventLoopFuture<Int>
}

struct DatabaseSpendingMethodRepository: SpendingMethodRepository, DatabaseRepository {
    let database: Database
    
    func create(_ spendingMethod: SpendingMethod) -> EventLoopFuture<Void> {
        return spendingMethod.create(on: database)
    }
    
    func delete(id: UUID) -> EventLoopFuture<Void> {
        return SpendingMethod.query(on: database)
            .filter(\.$id == id)
            .delete()
    }
    func update(_ spendingMethod: SpendingMethod) -> EventLoopFuture<Void> {
        return spendingMethod.save(on: database)
    }
    
    func all() -> EventLoopFuture<[SpendingMethod]> {
        return SpendingMethod.query(on: database)
            .sort(\.$createdAt, .descending).all()
    }
    
    func find(id: UUID?) -> EventLoopFuture<SpendingMethod?> {
        return SpendingMethod.find(id, on: database)
    }
    
    func count() -> EventLoopFuture<Int> {
        return SpendingMethod.query(on: database).count()
    }
}

extension Application.Repositories {
    var spendingMethods: SpendingMethodRepository {
        guard let storage = storage.makeSpendingMethodRepository else {
            fatalError("SpendingMethodRepository not configured, use: app.spendingMethodRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (SpendingMethodRepository)) {
        storage.makeSpendingMethodRepository = make
    }
}
