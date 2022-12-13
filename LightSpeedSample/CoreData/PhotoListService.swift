//
//  PhotoListService.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-10.
//

import Foundation
import CoreData
import CoreImage

public final class PhotoListService {
  // MARK: - Properties
  private let managedObjectContext: NSManagedObjectContext
  private let coreDataStack: CoreDataStack

  // MARK: - Initializers
  public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
    self.managedObjectContext = managedObjectContext
    self.coreDataStack = coreDataStack
  }
}

// MARK: - Public
extension PhotoListService {
    @discardableResult
    func add(_ photoObj:Photos , completion: @escaping (Bool?, Error?) -> Void) -> PhotoLocal {
        let report = PhotoLocal(context: managedObjectContext)
        report.id =  photoObj.id ?? ""
        report.author = photoObj.author ?? ""
        report.width = Int64(photoObj.width ?? 0)
        report.height = Int64(photoObj.height ?? 0)
        report.url = photoObj.url ?? ""
        report.download_url = photoObj.download_url ?? ""
        report.imageData = photoObj.imageData ?? Data()
        coreDataStack.saveContext(managedObjectContext) { status, error in
            completion(status,error)
        }
        return report
    }

    public func getPhotos() -> [PhotoLocal]? {
        let reportFetch: NSFetchRequest<PhotoLocal> = PhotoLocal.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(reportFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }

}
