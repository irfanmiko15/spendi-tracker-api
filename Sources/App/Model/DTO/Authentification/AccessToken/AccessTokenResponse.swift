//
//  AccessTokenResponse.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor

struct AccessTokenResponse: Content {
    let refreshToken: String
    let accessToken: String
}
