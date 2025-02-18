//
//  Authenticator.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor
import JWT

struct UserAuthenticator: JWTAuthenticator {
    typealias Payload = App.Payload
    
    func authenticate(jwt: Payload, for request: Request) -> EventLoopFuture<Void> {
        request.auth.login(jwt)
        return request.eventLoop.makeSucceededFuture(())
    }
}
