//
//  IncomeResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor

struct IncomeResponse: Content{
    let id: UUID?
    let spendingMethod: SpendingMethod
    let month: Int
    let year: Int
    let amount: Double
    let createdAt: Date
    let updatedAt: Date
    
    init(id: UUID? = nil, spendingMethod: SpendingMethod, month: Int, year: Int, amount: Double, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.spendingMethod = spendingMethod
        self.month = month
        self.year = year
        self.amount = amount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from income: Income) {
        self.init(id: income.id, spendingMethod: income.spendingMethod, month: income.month, year: income.year, amount: income.amount, createdAt: income.createdAt, updatedAt: income.updatedAt)
    }
}
