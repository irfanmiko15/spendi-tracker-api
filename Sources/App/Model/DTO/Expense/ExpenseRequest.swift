//
//  ExpenseRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor
struct ExpenseRequest: Content {
    let incomeId: UUID
    let description: String
    let expenseTypeId: UUID
    let amount: Double
    let transactionDate: String
    let createdAt: Date?
    let updatedAt: Date?
}
