//
//  TableMO+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TableMO)
public class TableMO: FurnitureMO {
    override func convertedPlainObject() -> Table {
        return Table(name: self.name ?? "",
                     material: Material(rawValue: self.material ?? "") ?? Material.wood)
    }
    
    func setup(from chair: Table) {
        self.name = chair.name
        self.material = chair.material.rawValue
    }
}
