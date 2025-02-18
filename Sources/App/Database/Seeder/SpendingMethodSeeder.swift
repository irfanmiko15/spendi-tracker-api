//
//  IncomeTypeSeeder.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Fluent
import Vapor

struct SpendingMethodSeeder {
    static func seed(on database: Database) -> EventLoopFuture<Void> {
        let methods = [
            SpendingMethod(method: "50/30/20", createdAt: Date(), updatedAt: Date()),
            SpendingMethod(method: "40/30/20/10", createdAt: Date(), updatedAt: Date()),
        ]
        
        return SpendingMethod.query(on: database).count().flatMap { count in
            guard count == 0 else { return database.eventLoop.makeSucceededFuture(()) }
            return methods.create(on: database)
        }
    }
}
