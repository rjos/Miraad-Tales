//
//  PlayerStatus.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class PlayerStatus: Status {

    public var XP: Int = 0
    public var lvl: Int = 1
    public var currentXP: Int = 0
    
    public override init(HP: Int, MP: Int, Speed: Int, pAtk: Int, mAtk: Int, pDef: Int, mDef: Int) {
        super.init(HP: HP, MP: MP, Speed: Speed, pAtk: pAtk, mAtk: mAtk, pDef: pDef, mDef: mDef)
    }
    
    // MARK: -Function increment Status
    public func incrementHP(percenteIncrement: Double) {
        let tempHP = (Double(self.XP) * percenteIncrement)
        self.HP = Int(tempHP)
    }
    
    public func incrementMP(percenteIncrement: Double) {
        let tempMP = (Double(self.XP) * percenteIncrement)
        self.MP = Int(tempMP)
    }
    
    public func incrementPAtk(percenteIncrement: Double) {
        let tempPAtk = (Double(self.XP) * percenteIncrement)
        self.pAtk = Int(tempPAtk)
    }
    
    public func incrementMAtk(percenteIncrement: Double) {
        let tempMAtk = (Double(self.XP) * percenteIncrement)
        self.mAtk = Int(tempMAtk)
    }
    
    public func incrementPDef(percenteIncrement: Double) {
        let tempPdef = (Double(self.XP) * percenteIncrement)
        self.pDef = Int(tempPdef)
    }
    
    public func incrementMDef(percenteIncrement: Double) {
        let tempMDef = (Double(self.XP) * percenteIncrement)
        self.mDef = Int(tempMDef)
    }
    
    public func incrementSpeed(percenteIncrement: Double) {
        let tempSpeed = (Double(self.XP) * percenteIncrement)
        self.Speed = Int(tempSpeed)
    }
    
    // MARK: -Functions increment/decrement XP
    public func incrementXP() {
        
        let powXP = pow(Double(self.lvl),2.0)
        self.XP = 20 * Int(powXP)
    }
    
    public func incrementLvl() {
        self.lvl += 1
        self.incrementXP()
    }
    
    public func incrementCurrentXP(winXP: Int) {
        self.currentXP += winXP
        
        if self.currentXP >= self.XP {
            self.currentXP -= self.XP
            self.incrementLvl()
        }
    }
    
    public func deathPenalty() {
        let subCurrentXP = Double(self.currentXP) * 0.05
        self.currentXP = max(0, (self.currentXP - Int(subCurrentXP)))
    }
}
