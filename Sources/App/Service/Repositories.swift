//
//  Repositories.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor
import Fluent

protocol Repository: RequestService {}

protocol DatabaseRepository: Repository {
    var database: Database { get }
    init(database: Database)
}

extension DatabaseRepository {
    func `for`(_ req: Request) -> Self {
        return Self.init(database: req.db)
    }
}

extension Application {
    struct Repositories {
        struct Provider {
            static var database: Self {
                .init {
                    $0.repositories.use { DatabaseUserRepository(database: $0.db) }
                    $0.repositories.use { DatabaseEmailTokenRepository(database: $0.db) }
                    $0.repositories.use { DatabaseRefreshTokenRepository(database: $0.db) }
                    $0.repositories.use { DatabasePasswordTokenRepository(database: $0.db) }
                    $0.repositories.use { DatabaseIncomeRepository(database: $0.db ) }
                    $0.repositories.use { DatabaseSpendingMethodRepository(database: $0.db ) }
                    $0.repositories.use { DatabaseExpenseTypeRepository(database: $0.db ) }
                    $0.repositories.use { DatabaseExpenseRepository(database: $0.db)}
                }
            }
            
            let run: (Application) -> ()
        }
        
        final class Storage {
            var makeUserRepository: ((Application) -> UserRepository)?
            var makeEmailTokenRepository: ((Application) -> EmailTokenRepository)?
            var makeRefreshTokenRepository: ((Application) -> RefreshTokenRepository)?
            var makePasswordTokenRepository: ((Application) -> PasswordTokenRepository)?
            var makeIncomeRepository: ((Application) -> IncomeRepository)?
            var makeSpendingMethodRepository: ((Application) -> SpendingMethodRepository)?
            var makeExpenseTypeRepository: ((Application) -> ExpenseTypeRepository)?
            var makeExpenseRepository:((Application)-> ExpenseRepository)?
            init() { }
        }
        
        struct Key: StorageKey {
            typealias Value = Storage
        }
        
        let app: Application
        
        func use(_ provider: Provider) {
            provider.run(app)
        }
        
        var storage: Storage {
            if app.storage[Key.self] == nil {
                app.storage[Key.self] = .init()
            }
            
            return app.storage[Key.self]!
        }
    }
    
    var repositories: Repositories {
        .init(app: self)
    }
}
