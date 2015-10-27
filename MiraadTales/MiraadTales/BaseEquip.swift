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
    public let requiredLevel: NSNumber
    public let skill: Skill?
    public let unlocked: Bool
    
    public init(name: String, ownerRace: PlayersRace, status: Status, type:ItemType, requiredLevel: NSNumber, skill: Skill?, unlocked: Bool) {
        
        self.ownerRace = ownerRace
        self.status = status
        self.requiredLevel = requiredLevel
        self.skill = skill
        self.unlocked = unlocked
        super.init(name: name, type: type)
    }

}
