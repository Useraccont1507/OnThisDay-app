//
//  Builder.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol BuilderProtocol {
  func buildGreeting(coordinator: CoordinatorProtocol) -> UIViewController
  func buildMainScreen(coordinator: CoordinatorProtocol) -> UIViewController
  func buildCalendarWith(coordinator: CoordinatorProtocol, selectedDate: Date) -> UIViewController
  func buildEvents(eventType: EventType, selectedDate: Date) -> UIViewController
  func buildFavorites(coordinator: CoordinatorProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
  private let networkService = NetworkService()
  private let storageService = StorageService()
  
  func buildGreeting(coordinator: CoordinatorProtocol) -> UIViewController {
    let viewModel = GreetingViewModel(coordinator: coordinator)
    return GreetingViewController(viewModel: viewModel)
  }
  
  func buildMainScreen(coordinator: CoordinatorProtocol) -> UIViewController {
    let viewModel = MainViewModel(coordinator: coordinator)
    return MainViewController(viewModel: viewModel)
  }
  
  func buildCalendarWith(coordinator: CoordinatorProtocol, selectedDate: Date) -> UIViewController {
    let viewModel = CalendarViewModel(coordinator: coordinator, selectedDate: selectedDate)
    return CalendarViewController(viewModel: viewModel)
  }
  
  func buildEvents(eventType: EventType, selectedDate: Date) -> UIViewController {
    let viewModel = EventsViewModel(networkService: networkService, storageService: storageService, eventType: eventType, selecteDate: selectedDate)
    return EventsViewController(viewModel: viewModel)
  }
  
  func buildFavorites(coordinator: CoordinatorProtocol) -> UIViewController {
    let viewModel = FavoritesViewModel(storage: storageService)
    return FavoritesViewController(viewModel: viewModel)
  }
}
