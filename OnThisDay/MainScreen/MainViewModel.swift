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
  func moveToFavorites()
}

class MainViewModel: MainViewModelProtocol {
  private let coordinator: CoordinatorProtocol?
  
  var date: Observer<Date> = .init(value: Date.now)
  var dateType: Observer<DateType> = .init(value: .dateNow)
  var eventType: Observer<EventType> = .init(value: .all)
  
  init(coordinator: CoordinatorProtocol?) {
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
    coordinator?.showCalendar(from: from)
  }
  
  func selectDateNow() {
    date.value = .now
    dateType.value = .dateNow
  }
  
  func moveToFavorites() {
    coordinator?.showFavorites()
  }
}
