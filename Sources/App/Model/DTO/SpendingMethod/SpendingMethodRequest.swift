//
//  SpendingMethodRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 18/02/25.
//
import Vapor
struct SpendingMethodRequest: Content {
    
    let id: UUID?
    let method: String
    let createdAt: Date?
    let updatedAt: Date?
    
}
