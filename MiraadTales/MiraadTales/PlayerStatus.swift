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
