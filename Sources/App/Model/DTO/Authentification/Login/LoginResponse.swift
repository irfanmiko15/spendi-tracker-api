//
//  LoginResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor

struct LoginResponse: Content {
    let user: UserDTO
    let accessToken: String
    let refreshToken: String
}
