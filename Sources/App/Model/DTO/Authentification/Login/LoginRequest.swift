//
//  LoginRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//
import Vapor

struct LoginRequest: Content {
    let email: String
    let password: String
}

extension LoginRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: !.empty)
    }
}
