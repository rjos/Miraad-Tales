//
//  Item.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Item: NSObject {
    
    public let name: String
    public let ownerRace: PlayersRace
    public let status: Status
    public let type: ItemType
    public let requiredLevel: NSNumber
    
    public init(name: String, ownerRace: PlayersRace, status: Status, type:ItemType, requiredLevel: NSNumber) {
        self.name = name
        self.ownerRace = ownerRace
        self.status = status
        self.type = type
        self.requiredLevel = requiredLevel
    }
}
