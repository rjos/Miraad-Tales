//
//  GeneralRace.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseRace: StatusList, DamageList{

    public let name: String
    public let status: PlayerStatus
    public var equipments: [Equip]
    public var skills: [Skill]
    public var isDie: Bool
    
    public init(name: String, status: PlayerStatus, equipments: [Equip], skills: [Skill], isDie: Bool) {
        self.name = name
        self.status = status
        self.equipments = equipments
        self.skills = skills
        self.isDie = isDie
    }
        
    public func incrementHP() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMP() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementPAtk() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMAtk() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementPDef() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMDef() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incremmentSpeed() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func calculateAtk() -> Int {
        let totalAtk = self.status.pAtk + self.status.mAtk
        return totalAtk
    }
    
    public func calculateDef() -> Int {
        let totalDef = self.status.pDef + self.status.mDef
        return totalDef
    }
}
