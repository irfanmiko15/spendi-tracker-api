//
//  ExpenseType.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Fluent
import Vapor

final class ExpenseType: Model, Content {
    static let schema = "expense_type"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "value")
    var value: Int
    
    @Field(key: "created_at")
    var createdAt: Date
    
    @Field(key: "updated_at")
    var updatedAt: Date
    
    @Parent(key: "spending_method_id")
    var spendingMethod: SpendingMethod
    
    init() { }
    
    init(id: UUID? = nil, description: String,value: Int ,spendingMethodID: UUID, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.description = description
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.$spendingMethod.id = spendingMethodID
    }
}

