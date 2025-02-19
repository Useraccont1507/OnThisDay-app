//
//  Builder.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol AssemblyBuilderProtocol {
  func buildGreeting(router: RouterProtocol) -> UIViewController
  func buildMainScreen(router: RouterProtocol) -> UIViewController
  func buildCalendarWith(router: RouterProtocol, selectedDate: Date) -> UIViewController
  func buildEvents(eventType: EventType, selectedDate: Date) -> UIViewController
  func buildFavorites(router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
  private let networkService = NetworkService()
  private let storageService = StorageService()
  
  func buildGreeting(router: RouterProtocol) -> UIViewController {
    let viewModel = GreetingViewModel(router: router)
    return GreetingViewController(viewModel: viewModel)
  }
  
  func buildMainScreen(router: RouterProtocol) -> UIViewController {
    let viewModel = MainViewModel(router: router)
    return MainViewController(viewModel: viewModel)
  }
  
  func buildCalendarWith(router: RouterProtocol, selectedDate: Date) -> UIViewController {
    let viewModel = CalendarViewModel(router: router, selectedDate: selectedDate)
    return CalendarViewController(viewModel: viewModel)
  }
  
  func buildEvents(eventType: EventType, selectedDate: Date) -> UIViewController {
    let viewModel = EventsViewModel(networkService: networkService, storageService: storageService, eventType: eventType, selecteDate: selectedDate)
    return EventsViewController(viewModel: viewModel)
  }
  
  func buildFavorites(router: RouterProtocol) -> UIViewController {
    let viewModel = FavoritesViewModel(storage: storageService)
    return FavoritesViewController(viewModel: viewModel)
  }
}
