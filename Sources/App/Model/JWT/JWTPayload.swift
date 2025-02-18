//
//  JWTPayload.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor
import JWT

struct Payload: JWTPayload, Authenticatable {
    // User-releated stuff
    var userID: UUID
    var firstName: String
    var lastName: String
    var email: String
    
    // JWT stuff
    var exp: ExpirationClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.exp.verifyNotExpired()
    }
    
    init(with user: User) throws {
        self.userID = try user.requireID()
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
       
        self.exp = ExpirationClaim(value: Date().addingTimeInterval(Constants.ACCESS_TOKEN_LIFETIME))
    }
}

extension User {
    convenience init(from payload: Payload) {
        self.init(id: payload.userID, firstName: payload.firstName, lastName: payload.lastName, email: payload.email, passwordHash: "")
    }
}
