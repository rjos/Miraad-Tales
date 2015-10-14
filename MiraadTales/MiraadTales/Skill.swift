//
//  BaseSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Skill: NSObject {
    
    public let name: String
    public let equip: Equip
    public let owner: BaseRace
    public let status: Status
    public let criticalRate: NSNumber
    public let missRate: NSNumber
    public let consumeMana: NSNumber
    public let effect: Effect
    public let details: String
    
    public init(name: String, equip: Equip, owner: BaseRace,status: Status, criticalRate: NSNumber, missRate: NSNumber, consumeMana: NSNumber, effect: Effect, details: String) {
        self.name = name
        self.equip = equip
        self.owner = owner
        self.status = status
        self.criticalRate = criticalRate
        self.missRate = missRate
        self.consumeMana = consumeMana
        self.effect = effect
        self.details = details
    }
    
}
