//
//  SpendingMethod.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Vapor
import Fluent
final class SpendingMethod: Model, Content {
    static let schema = "spending_method"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "method")
    var method: String
    
    @Field(key: "created_at")
    var createdAt: Date
    
    @Field(key: "updated_at")
    var updatedAt: Date
    
    init() {}
    
    init(
        id: UUID? = nil,
        method: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.method = method
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
