//
//  ExpenseResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor

struct ExpenseResponse: Content{
    let id: UUID?
    let income: Income
    let description: String
    let expenseType: ExpenseType
    let amount: Double
    let transactionDate: Date
    let createdAt: Date
    let updatedAt: Date
    
    init(id: UUID? = nil,income: Income, expenseType:ExpenseType,description:String,transactionDate:Date , amount: Double, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.income = income
        self.expenseType = expenseType
        self.description = description
        self.transactionDate = transactionDate
        self.amount = amount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from expense: Expense) {
        self.init(id: expense.id, income: expense.income,expenseType: expense.expenseType,description: expense.description , transactionDate: expense.transactionDate, amount: expense.amount, createdAt: expense.createdAt, updatedAt: expense.updatedAt)
    }
}
