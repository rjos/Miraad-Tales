//
//  Skill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public enum DamageSkillType: String {
    case HP = "DamageHP"
    case Speed = "DamageSpeed"
    case Atk = "DamageAtk"
    case Def = "DamageDef"
}

public class DamageSKill: BaseSkill {
    
    public let pDam: NSNumber
    public let mDam: NSNumber
    public let descreaseDamage: NSNumber
    
    public init(name:String, ownerRace:PlayersRace, effects: String, pDam: NSNumber, mDam: NSNumber, descreaseDamage: NSNumber) {
        self.pDam = pDam
        self.mDam = mDam
        self.descreaseDamage = descreaseDamage
        super.init(name: name, ownerRace: ownerRace, effects: effects)
    }
}
