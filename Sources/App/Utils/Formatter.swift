//
//  Formatter.swift
//  spendi_tracker_api
//
//  Created by Irfan Dary Sujatmiko on 19/02/25.
//
import Vapor
struct FormatUtils{
    func date(date: String) -> Date {
            let formatter = ISO8601DateFormatter()
            if let parsedDate = formatter.date(from: date) {
                print("Parsed Date: \(parsedDate)")
                return parsedDate
            } else {
                print("Failed to parse date, returning current date.")
                return Date()
            }
    }
}
