//
//  TableMO+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData


extension TableMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TableMO> {
        return NSFetchRequest<TableMO>(entityName: "TableMO")
    }


}
