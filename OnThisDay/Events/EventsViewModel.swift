//
//  EventsViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import Foundation
protocol EventsViewModelProtocol {
  func saveEvent(index: Int)
}

class EventsViewModel: EventsViewModelProtocol {
  var events: Observer<[EventModel]> = Observer(value: [])
  var eventType: EventType
  var selectedRows: [Int] = []
  private let selectedDate: Date
  private let networkService: NetworkServiceProtocol
  private var storageService: StorageServiceProtocol
  
  init(networkService: NetworkServiceProtocol, storageService: StorageService, eventType: EventType, selecteDate: Date) {
    self.networkService = networkService
    self.storageService = storageService
    self.eventType = eventType
    self.selectedDate = selecteDate
    fetchEvents()
  }
  
  private func getMonthAndDate(from: Date) -> (Int, Int) {
    let calendar = Calendar(identifier: .gregorian)
    let month = calendar.component(.month, from: from)
    let day = calendar.component(.day, from: from)
    return (day, month)
  }
  
  private func fetchEvents() {
    let monthAndDay = getMonthAndDate(from: selectedDate)
    
    networkService.fetchEvents(eventType: eventType, day: monthAndDay.0, month: monthAndDay.1) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let success):
          if let births = success.births {
            self.events.value = births.map { birth in
              EventModel(
                title: birth.wikipedia.first?.title,
                description: birth.description,
                year: birth.year,
                type: "Births"
              )
            }
          }
          
          if let deaths = success.deaths {
            self.events.value = deaths.map { death in
              EventModel(
                title: death.wikipedia.first?.title,
                description: death.description,
                year: death.year,
                type: "Deaths"
              )
            }
          }
          
          if let events = success.events {
            self.events.value = events.map { event in
              EventModel(
                title: event.wikipedia.first?.title,
                description: event.description,
                year: event.year,
                type: "Events"
              )
            }
          }
        case .failure(let failure):
          print(failure)
        }
      }
    }
  }
  
  func saveEvent(index: Int) {
    storageService.addEventToStorage(event: events.value[index])
  }
}
