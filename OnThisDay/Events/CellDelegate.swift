//
//  CellDelegate.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import Foundation

protocol SelectedRowDelegate: AnyObject {
  func addToFavorites(index: Int)
}
