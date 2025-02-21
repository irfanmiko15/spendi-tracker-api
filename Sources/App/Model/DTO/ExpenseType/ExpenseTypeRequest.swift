//
//  ExpenseTypeRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//

import Vapor

struct ExpenseTypeRequest: Content{
    let spendingMethodId: UUID
    let description: String
    let value: Int
    let createdAt: Date?
    let updatedAt: Date?
}
