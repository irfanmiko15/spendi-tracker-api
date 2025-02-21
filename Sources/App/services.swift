//
//  services.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 13/02/25.
//

import Vapor

func services(_ app: Application) throws {
    app.randomGenerators.use(.random)
    app.repositories.use(.database)
}
