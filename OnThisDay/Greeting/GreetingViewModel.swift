//
//  GreetingViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import Foundation

protocol GreetingViewModelProtocol {
  func moveToMainScreen()
}

class GreetingViewModel: GreetingViewModelProtocol {
  private let coordinator: CoordinatorProtocol
  
  init(coordinator: CoordinatorProtocol) {
    self.coordinator = coordinator
  }
  
  func moveToMainScreen() {
    //TODO: moveToMain
  }
}
