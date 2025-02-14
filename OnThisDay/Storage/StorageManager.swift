//
//  StorageManager.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import CoreData

final class StorageManager {
  static let shared = StorageManager()
  
  let persistentContainer: NSPersistentContainer
  
  private init() {
    persistentContainer = NSPersistentContainer(name: "OnThisDay")
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Failed to load persistent stores: \(error.localizedDescription)")
      }
    }
  }
  
  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }
}
