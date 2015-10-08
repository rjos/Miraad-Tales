//
//  Item.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Equip: BaseItem {
    
    public let ownerRace: PlayersRace
    public let owner: BaseRace
    public let status: Status
    public let requiredLevel: NSNumber
    public let skill: BaseSkill
    
    public init(name: String, ownerRace: PlayersRace, owner: BaseRace,status: Status, type:ItemType, requiredLevel: NSNumber, skill: BaseSkill) {
        
        self.ownerRace = ownerRace
        self.owner = owner
        self.status = status
        self.requiredLevel = requiredLevel
        self.skill = skill
        super.init(name: name, type: type)
    }
}
