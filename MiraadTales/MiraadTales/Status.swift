//
//  Status.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    // MARK: -Attributes
    var HP: Int = 0
    var MP: Int = 0
    var Speed: Int = 0
    var XP: Int = 0
    var lvl: Int = 1
    var currentXP: Int = 0
    var pAtk: Int = 0
    var mAtk: Int = 0
    var pDef: Int = 0
    var mDef: Int = 0
    
    init(HP:Int, MP:Int, Speed:Int, pAtk: Int, mAtk:Int, pDef: Int, mDef:Int) {
        super.init()
        
        self.HP = HP
        self.MP = MP
        self.Speed = Speed
        self.pAtk = pAtk
        self.mAtk = mAtk
        self.pDef = pDef
        self.mDef = mDef
    }
    
    // MARK: -Functions Abstracts
    func incrementHP() {
        
    }
    
    func incrementMP() {
        
    }
    
    func incrementSpeed() {
        
    }
    
    func incrementPAtk() {
        
    }
    
    func incrementMAtk() {
        
    }
    
    func incrementPDef() {
        
    }
    
    func incrementMDef() {
        
    }
    
    // MARK: -Functions General Classes
    func incrementCurrentXP(winXP: Int) {
        self.currentXP += winXP
        
        if self.currentXP >= self.XP {
            self.incrementLvl()
        }
    }
    
    func incrementXP() {
        
        let powXP = pow(Double(self.lvl),2.0)
        self.XP = 20 * Int(powXP)
    }
    
    func incrementLvl() {
        self.lvl += 1
        self.incrementXP()
    }
}
