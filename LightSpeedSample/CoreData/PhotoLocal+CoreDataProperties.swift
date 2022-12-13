//
//  Photo+CoreDataProperties.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//
//

import Foundation
import CoreData

extension PhotoLocal {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoLocal> {
        return NSFetchRequest<PhotoLocal>(entityName: "PhotoLocal")
    }
    @NSManaged public var id: String?
    @NSManaged public var author: String?
    @NSManaged public var width: Int64
    @NSManaged public var height: Int64
    @NSManaged public var url: String?
    @NSManaged public var download_url: String?
    @NSManaged public var imageData: Data?
}

extension PhotoLocal : Identifiable {
}
