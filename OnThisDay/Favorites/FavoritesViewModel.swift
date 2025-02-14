//
//  FavoritesViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import Foundation

protocol FavoritesViewModelProtocol {
  func deleteEvent(index: Int)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
  let storage: StorageService
  let events: Observer<[EventModel]> = Observer(value: [])
  
  init(storage: StorageService) {
    self.storage = storage
    loadEvents()
  }
  
  private func loadEvents() {
    events.value = storage.fetchEvents()
  }
  
  func deleteEvent(index: Int) {
    let event = events.value.remove(at: index)
    storage.deleteEventFromStorage(event: event)
  }
}
