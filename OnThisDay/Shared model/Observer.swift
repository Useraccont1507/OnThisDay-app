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
      listeners.forEach { listener in
        listener(value)
      }
    }
  }
  
  init(value: T) {
    self.value = value
  }
  
  private var listeners: [(T) -> Void] = []
  
  func bind(listener: @escaping (T) -> Void) {
    listener(value)
    listeners.append(listener)
  }
}
