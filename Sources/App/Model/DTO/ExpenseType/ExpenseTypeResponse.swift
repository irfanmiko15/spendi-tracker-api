//
//  ExpenseTypeResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor

struct ExpenseTypeResponse: Content{
    let id: UUID?
    let spendingMethod: SpendingMethod
    let description: String
    let value: Int
    let createdAt: Date
    let updatedAt: Date
    
    init(id: UUID? = nil, spendingMethod: SpendingMethod, description:String, value: Int, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.description = description
        self.value = value
        self.spendingMethod = spendingMethod
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from expenseType: ExpenseType) {
        self.init(id: expenseType.id, spendingMethod: expenseType.spendingMethod, description: expenseType.description, value: expenseType.value, createdAt: expenseType.createdAt, updatedAt: expenseType.updatedAt)
    }
}
