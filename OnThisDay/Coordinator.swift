//
//  Coordinator.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol CoordinatorProtocol {
  func showGreeting(builder: BuilderProtocol)
}

class Coordinator: CoordinatorProtocol {
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    navigationController.view.backgroundColor = .systemBackground
  }
  
  func showGreeting(builder: BuilderProtocol) {
    let greeting = builder.buildGreeting(coordinator: self)
    navigationController.viewControllers = [greeting]
  }
}
