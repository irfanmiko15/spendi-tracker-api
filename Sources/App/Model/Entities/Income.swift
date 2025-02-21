//
//  Income.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor
import Fluent

final class Income: Model {
    static let schema = "user_income"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "spending_method_id")
    var spendingMethod: SpendingMethod
    
    @Field(key: "month")
    var month: Int
    
    @Field(key: "amount")
    var amount: Double
    
    @Field(key: "year")
    var year: Int
    
    @Field(key: "created_at")
    var createdAt: Date
    
    @Field(key: "updated_at")
    var updatedAt: Date
    
    init() {}
    
    init(
        id: UUID? = nil,
        user: UUID,
        spendingMethod: UUID,
        month: Int,
        year: Int,
        amount: Double,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.$user.id = user
        self.$spendingMethod.id = spendingMethod
        self.month = month
        self.amount = amount
        self.year = year
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
