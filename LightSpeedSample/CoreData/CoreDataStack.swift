//
//  CoreDataStack.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-10.
//


import Foundation
import CoreData

open class CoreDataStack {
    public static let modelName = "LightSpeedSample"

    public static let model: NSManagedObjectModel = {
        // swiftlint:disable force_unwrapping
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    public init() {
    }
    
    public lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()

    public lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()


    public func saveContext(_ context: NSManagedObjectContext,completion: @escaping(Bool, NSError?) -> Void) {
        context.perform {
            do {
                try context.save()
                completion(true, nil)
            } catch let error as NSError {
                completion(false, error)
            }
        }
    }

}
