//
//  Mage.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Mage: BaseRace {

    public override init(name: String, status: PlayerStatus, equipments: [Equip], skills: [Skill], isDie: Bool) {
        super.init(name: name, status: status, equipments: equipments, skills: skills, isDie: isDie)
    }
    
    public override func incrementHP() {
        self.status.incrementHP(0.1)
    }
    
    public override func incrementMP() {
        self.status.incrementMP(0.25)
    }
    
    public override func incrementPAtk() {
        self.status.incrementPAtk(0.1)
    }
    
    public override func incrementMAtk() {
        self.status.incrementMAtk(0.25)
    }
    
    public override func incrementPDef() {
        self.status.incrementPDef(0.15)
    }
    
    public override func incrementMDef() {
        self.status.incrementMDef(0.25)
    }
    
    public override func incremmentSpeed() {
        self.status.incrementSpeed(0.1)
    }
}
