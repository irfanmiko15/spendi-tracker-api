//
//  Expense.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//


import Vapor
import Fluent

final class Expense: Model {
    static let schema = "user_expense"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "income_id")
    var income: Income
    
    @Parent(key: "expense_type_id")
    var expenseType: ExpenseType
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "amount")
    var amount: Double
    
    @Field(key: "transaction_date")
    var transactionDate: Date
    
    @Field(key: "created_at")
    var createdAt: Date
    
    @Field(key: "updated_at")
    var updatedAt: Date
    
    init() {}
    
    init(
        id: UUID? = nil,
        income: UUID,
        expenseType: UUID,
        description: String,
        amount: Double,
        transactionDate: Date,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.$income.id = income
        self.$expenseType.id = expenseType
        self.description = description
        self.amount = amount
        self.transactionDate = transactionDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

