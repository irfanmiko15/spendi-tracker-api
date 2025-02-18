//
//  IncomeRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//

import Vapor

struct IncomeRequest: Content {
    let spendingMethod: UUID
    let month: Int
    let year: Int
    let amount: Double
    let createdAt: Date?
    let updatedAt: Date?
}
