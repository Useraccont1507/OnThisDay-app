//
//  Observer.swift
//  OnThisDay
//
//  Created by Illia Verezei on 11.02.2025.
//

import Foundation

class Observer<T> {
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(value: T) {
    self.value = value
  }
  
  private var listener: ((T) -> Void)?
  
  func bind(listener: @escaping (T) -> Void) {
    listener(value)
    self.listener = listener
  }
}
