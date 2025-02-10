//
//  Builder.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

protocol BuilderProtocol {
  func buildGreeting(coordinator: CoordinatorProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
  func buildGreeting(coordinator: CoordinatorProtocol) -> UIViewController {
    let viewModel = GreetingViewModel(coordinator: coordinator)
    return GreetingViewController(viewModel: viewModel)
  }
}
