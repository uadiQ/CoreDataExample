//
//  ChairMO+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData


extension ChairMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChairMO> {
        return NSFetchRequest<ChairMO>(entityName: "ChairMO")
    }

    @NSManaged public var isAdjustable: Bool

}
