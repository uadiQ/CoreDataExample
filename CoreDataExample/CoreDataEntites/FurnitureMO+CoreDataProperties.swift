//
//  FurnitureMO+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData


extension FurnitureMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FurnitureMO> {
        return NSFetchRequest<FurnitureMO>(entityName: "FurnitureMO")
    }

    @NSManaged public var name: String?
    @NSManaged public var material: String?

}
