//
//  Coordinator.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol RouterProtocol {
  func showGreeting()
  func showMainScreen()
  func showCalendar(from: UIViewController)
  func dismiss(vc: UIViewController)
  func showEvents(withType: EventType)
  func showFavorites()
}

class Router: RouterProtocol {
  private let navigationController: UINavigationController
  private let builder: AssemblyBuilderProtocol
  var selectedDate = Observer<Date>(value: .now)
  
  init(navigationController: UINavigationController, builder: AssemblyBuilderProtocol) {
    self.navigationController = navigationController
    self.builder = builder
  }
  
  func showGreeting() {
    let greeting = builder.buildGreeting(coordinator: self)
    navigationController.viewControllers = [greeting]
  }
  
  func showMainScreen() {
    let mainScreen = builder.buildMainScreen(coordinator: self)
    self.navigationController.setViewControllers([mainScreen], animated: true)
  }
  
  func showCalendar(from: UIViewController) {
    let calendarView = builder.buildCalendarWith(coordinator: self, selectedDate: selectedDate.value)
    from.present(calendarView, animated: true)
  }
  
  func dismiss(vc: UIViewController) {
    vc.dismiss(animated: true)
  }
  
  func showEvents(withType: EventType) {
    let eventsView = builder.buildEvents(eventType: withType, selectedDate: selectedDate.value)
    navigationController.pushViewController(eventsView, animated: true)
  }
  
  func showFavorites() {
    let favoritesView = builder.buildFavorites(coordinator: self)
    navigationController.pushViewController(favoritesView, animated: true)
  }
}
