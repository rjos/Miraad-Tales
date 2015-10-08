//
//  BaseItem.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseItem: NSObject {

    public let name: String
    public let type: ItemType
    
    public init(name: String, type: ItemType) {
        self.name = name
        self.type = type
    }
}
