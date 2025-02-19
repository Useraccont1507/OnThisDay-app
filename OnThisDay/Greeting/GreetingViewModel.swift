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
  private let router: RouterProtocol
  
  init(router: RouterProtocol) {
    self.router = router
  }
  
  func moveToMainScreen() {
      router.showMainScreen()
  }
}
