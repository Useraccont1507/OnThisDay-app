//
//  Coordinator.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol CoordinatorProtocol {
  func showGreeting()
  func showCalendar(from: UIViewController)
}

class Coordinator: CoordinatorProtocol {
  private let navigationController: UINavigationController
  private let builder: BuilderProtocol
  
  init(navigationController: UINavigationController, builder: BuilderProtocol) {
    self.navigationController = navigationController
    navigationController.view.backgroundColor = .systemBackground
    self.builder = builder
  }
  
  func showGreeting() {
    let greeting = builder.buildGreeting(coordinator: self)
    navigationController.viewControllers = [greeting]
  }
  
  func showCalendar(from: UIViewController) {
    //TODO:
  }
}
