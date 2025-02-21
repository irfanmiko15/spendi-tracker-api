//
//  SendEmailVerificationRequest.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor

struct SendEmailVerificationRequest: Content {
    let email: String
}
