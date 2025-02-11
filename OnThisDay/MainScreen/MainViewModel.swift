//
//  MainViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 11.02.2025.
//

import UIKit

protocol MainViewModelProtocol {
  func chooseDate(from: UIViewController)
  func selectDateNow()
  func moveToFavorites()
}

class MainViewModel: MainViewModelProtocol {
  private let coordinator: CoordinatorProtocol?
  
  var dateType: Observer<DateType> = .init(value: .dateNow)
  
  init(coordinator: CoordinatorProtocol?) {
    self.coordinator = coordinator
  }
  
  func chooseDate(from: UIViewController) {
    dateType.value = .custom
    coordinator?.showCalendar(from: from)
  }
  
  func selectDateNow() {
    dateType.value = .dateNow
  }
  
  func moveToFavorites() {
     
  }
}
