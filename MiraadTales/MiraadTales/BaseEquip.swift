//
//  BaseEquip.swift
//  MiraadTales
//
//  Created by Rodolfo José on 27/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseEquip: BaseItem {

    public let ownerRace: PlayersRace
    public let status: Status
    public let requiredLevel: Int
    public var skill: Skill?
    public var isEquipped: Bool
    
    public init(name: String, ownerRace: PlayersRace, status: Status, type:ItemType, requiredLevel: Int, skill: Skill?, isEquipped: Bool) {
        
        self.ownerRace = ownerRace
        self.status = status
        self.requiredLevel = requiredLevel
        self.skill = skill
        self.isEquipped = isEquipped
        super.init(name: name, type: type)
    }

}
