//
//  RestoreSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public enum RestoreSkillType: String {
    case HP = "RestoreHP"
    case MP = "RestoreMP"
    case Atk = "RestoreAtk"
    case Def = "RestoreDef"
    case Speed = "RestoreSpeed"
}

public class RestoreSkill: BaseSkill {
    
    public let restore: NSNumber
    public let restoreType: RestoreSkillType
    
    public init(name: String, ownerRace: PlayersRace, effects: String, restore: NSNumber, restoreType: RestoreSkillType) {
        
        self.restore = restore
        self.restoreType = restoreType
        super.init(name: name, ownerRace: ownerRace, effects: effects)
    }
    
}
