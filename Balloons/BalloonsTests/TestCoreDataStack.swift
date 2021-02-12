//
//  TestCoreDataStack.swift
//  BalloonsTests
//
//  Created by Brena Amorim on 12/02/21.
//

import CoreData
import Balloons

class TestCoreDataStack: CoreDataStack {
    override init() {
    super.init()

    let shared = CoreDataStack()
    
    // Configuring persistent store for test In Memory
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(
        name: shared.modelName)

    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    storeContainer = container
  }
}
