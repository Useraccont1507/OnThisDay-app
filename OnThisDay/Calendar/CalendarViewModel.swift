//
//  CalendarViewModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 12.02.2025.
//

import UIKit

protocol CalendarViewModelProtocol {
  func updateDate(date: Date, vc: UIViewController)
}

class CalendarViewModel: CalendarViewModelProtocol {
  private let coordinator: CoordinatorProtocol
  
  var selectedDate = Date.now {
    didSet {
      NotificationCenter.default.post(name: Notification.Name("date"), object: selectedDate)
    }
  }
  
  init(coordinator: CoordinatorProtocol, selectedDate: Date) {
    self.coordinator = coordinator
    self.selectedDate = selectedDate
  }
  
  func updateDate(date: Date, vc: UIViewController) {
    selectedDate = date
    coordinator.dismiss(vc: vc)
  }
}
