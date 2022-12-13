//
//  Photo+CoreDataProperties.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-07.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: String?
    @NSManaged public var author: String?
    @NSManaged public var width: Int64
    @NSManaged public var height: Int64
    @NSManaged public var url: String?
    @NSManaged public var download_url: String?
    @NSManaged public var imageData: Data?

}

extension Photo : Identifiable {

}
