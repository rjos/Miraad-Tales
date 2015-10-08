//
//  Item.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Equip: NSObject {
    
    public let name: String
    public let ownerRace: PlayersRace
    public let status: Status
    public let type: EquipType
    public let requiredLevel: NSNumber
    public let skill: BaseSkill
    
    public init(name: String, ownerRace: PlayersRace, status: Status, type:EquipType, requiredLevel: NSNumber, skill: BaseSkill) {
        self.name = name
        self.ownerRace = ownerRace
        self.status = status
        self.type = type
        self.requiredLevel = requiredLevel
        self.skill = skill
    }
}
