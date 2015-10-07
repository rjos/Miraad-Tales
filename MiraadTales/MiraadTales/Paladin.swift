//
//  Paladin.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Paladin: GeneralRace, StatusList {

    public override init(name: String, status: PlayerStatus, equipments: [Item], skills: [BaseSkill]) {
        super.init(name: name, status: status, equipments: equipments, skills: skills)
    }
    
    public func incrementHP() {
        self.status.incrementHP(0.25)
    }
    
    public func incrementMP() {
        self.status.incrementMP(0.2)
    }
    
    public func incrementPAtk() {
        self.status.incrementPAtk(0.2)
    }
    
    public func incrementMAtk() {
        self.status.incrementMAtk(0.15)
    }
    
    public func incrementPDef() {
        self.status.incrementPDef(0.25)
    }
    
    public func incrementMDef() {
        self.status.incrementMDef(0.15)
    }
    
    public func incremmentSpeed() {
        self.status.incrementSpeed(0.1)
    }
}