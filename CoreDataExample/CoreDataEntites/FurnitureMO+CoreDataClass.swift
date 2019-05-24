//
//  FurnitureMO+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FurnitureMO)
public class FurnitureMO: NSManagedObject {
    func convertedPlainObject() -> Furniture {
        return Furniture(name: self.name ?? "",
                         material: Material(rawValue: self.material ?? "") ?? Material.wood)
    }
    
    func setup(from furniture: Furniture) {
        self.name = furniture.name
        self.material = furniture.material.rawValue
    }
}
