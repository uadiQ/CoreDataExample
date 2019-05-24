//
//  Chair.swift
//  CoreDataExample
//
//  Created by Software Station on 5/24/19.
//  Copyright © 2019 Software Station. All rights reserved.
//

import Foundation

enum Material: String {
    case wood
    case cloth
}

class Chair: Furniture {
    var isAdjustable: Bool
    
    init(name: String, material: Material, isAdjustable: Bool) {
        self.isAdjustable = isAdjustable
        super.init(name: name, material: material)
    }
}
