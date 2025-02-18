//
//  SpendingMethodResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//


import Vapor

struct SpendingMethodResponse: Content {
    
    let id: UUID?
    let method: String
    let createdAt: Date
    let updatedAt: Date?
    
    init(id: UUID? = nil, method: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.method = method
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from spendingMethod: SpendingMethod) {
        self.init(id: spendingMethod.id, method: spendingMethod.method, createdAt: spendingMethod.createdAt, updatedAt: spendingMethod.updatedAt)
    }
}
