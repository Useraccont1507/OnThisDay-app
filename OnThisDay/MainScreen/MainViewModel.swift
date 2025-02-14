//
//  MainViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 11.02.2025.
//

import UIKit

protocol MainViewModelProtocol {
  func selectEventType(fromIndex: Int)
  func chooseDate(from: UIViewController)
  func selectDateNow()
  func searchEvents()
  func moveToFavorites()
}

class MainViewModel: MainViewModelProtocol {
  private let coordinator: CoordinatorProtocol
  
  var date: Observer<Date> = Observer(value: Date.now)
  var dateType: Observer<DateType> = Observer(value: DateType.dateNow)
  var eventType: Observer<EventType> = Observer(value: EventType.events)
  
  init(coordinator: CoordinatorProtocol) {
    self.coordinator = coordinator
    addNotificationObserver()
  }
  
  private func addNotificationObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleDateChanges(_:)), name: Notification.Name("date"), object: nil)
  }
  
  @objc
  private func handleDateChanges(_ notification: Notification) {
    guard let dateFromCalendar = notification.object as? Date else { return }
    date.value = dateFromCalendar
  }
  
  func selectEventType(fromIndex: Int) {
    let type = EventType.allCases[fromIndex]
    eventType.value = type
  }
  
  func chooseDate(from: UIViewController) {
    dateType.value = .custom
    coordinator.showCalendar(from: from)
  }
  
  func selectDateNow() {
    date.value = .now
    dateType.value = .dateNow
  }
  
  func searchEvents() {
    coordinator.showEvents(withType: eventType.value)
  }
  
  func moveToFavorites() {
    coordinator.showFavorites()
  }
}
