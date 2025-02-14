//
//  StorageService.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import CoreData

protocol StorageServiceProtocol {
  func addEventToStorage(event: EventModel)
  func fetchEvents() -> [EventModel]
  func deleteEventFromStorage(event: EventModel)
}

class StorageService: StorageServiceProtocol {
  
  private let context: NSManagedObjectContext
  
  init() {
    self.context = StorageManager.shared.context
  }
  
  func addEventToStorage(event: EventModel) {
    let eventEntity = EventEntity(context: context)
    eventEntity.title = event.title
    eventEntity.eventDescription = event.description
    eventEntity.year = event.year
    eventEntity.eventType = event.type
    saveContext()
  }
  
  func fetchEvents() -> [EventModel] {
    let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
    do {
      return try context.fetch(request).map { entity in
        EventModel(
          title: entity.title,
          description: entity.eventDescription,
          year: entity.year,
          type: entity.eventType
        )
      }
    } catch {
      print("failed to fetch events: \(error.localizedDescription)")
      return []
    }
  }
  
  func deleteEventFromStorage(event: EventModel) {
    guard let title = event.title else { return }
    let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", title)
    
    do {
      if let entity = try context.fetch(request).first {
        context.delete(entity)
        saveContext()
      }
    } catch {
      print("Delete error: \(error.localizedDescription)")
    }
  }
  
  private func saveContext() {
    do {
      try context.save()
    } catch {
      print("failed to save changes")
    }
  }
}
