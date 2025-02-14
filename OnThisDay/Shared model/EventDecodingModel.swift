//
//  EventModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import Foundation

// MARK: - Events
struct EventsGeocoding: Codable {
  let wikipedia: String
  let date: String
  let events: [Event]?
  let births: [Birth]?
  let deaths: [Death]?
}

// MARK: - Event
struct Event: Codable {
    let year, description: String
    let wikipedia: [Wikipedia]
}

// MARK: - Birth
struct Birth: Codable {
  let year, description: String
  let wikipedia: [Wikipedia]
}

// MARK: - Death
struct Death: Codable {
    let year: String
    let wikipedia: [Wikipedia]
    let description: String
}

// MARK: - Wikipedia
struct Wikipedia: Codable {
    let title: String
    let wikipedia: String
}
