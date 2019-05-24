//
//  ChairMO+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ChairMO)
public class ChairMO: FurnitureMO {
   override func convertedPlainObject() -> Chair {
        return Chair(name: self.name ?? "",
                     material: Material(rawValue: self.material ?? "") ?? Material.wood,
                     isAdjustable: self.isAdjustable)
        
        
    }
    
    func setup(from chair: Chair) {
        self.name = chair.name
        self.material = chair.material.rawValue
        self.isAdjustable = chair.isAdjustable
    }
}
