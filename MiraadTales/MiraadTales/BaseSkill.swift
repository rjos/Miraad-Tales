//
//  BaseSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseSkill : DamageList {
    
    public let name: String
    public let fantasyName: String
    public var equip: Equip?
    public let ownerRace: PlayersRace
    public let status: Status
    public let criticalRate: Int
    public let missRate: Int
    public let consumeMana: Int
    public let effect: Effect?
    public let details: String
    
    public init(name: String, fantasyName:String, equip: Equip?, ownerRace: PlayersRace, status: Status, criticalRate: Int, missRate: Int, consumeMana: Int, effect: Effect?, details: String) {
        self.name = name
        self.fantasyName = fantasyName
        self.equip = equip
        self.ownerRace = ownerRace
        self.status = status
        self.criticalRate = criticalRate
        self.missRate = missRate
        self.consumeMana = consumeMana
        self.effect = effect
        self.details = details
    }
    
    public func increaseAtk() -> Int {
        let attack = (self.status.pAtk + self.status.mAtk)
        return attack
    }
    
    public func increaseDef() -> Int {
        let defense = (self.status.pDef + self.status.mDef)
        return defense
    }
    
    public func increaseSpeed() -> Int {
        return self.status.Speed
    }
    
    public func calculateAtk() -> Int {
        let totalAtk = self.status.pAtk + self.status.mAtk
        return totalAtk
    }
    
    public func calculateDef() -> Int {
        let totalDef = self.status.mDef + self.status.mDef
        return totalDef
    }
}
