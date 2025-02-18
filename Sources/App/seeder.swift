//
//  seeder.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 17/02/25.
//

import Vapor

func seed(_ app: Application) throws{
    try SpendingMethodSeeder.seed(on: app.db).wait()
    try ExpenseTypeSeeder.seed(on: app.db).wait()
}
