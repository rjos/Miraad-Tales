//
//  DBPlayers.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

public class DBPlayers {
    
    //MARK: Get Person Hydora
    public static func getPaladin() -> Player {
        
        let status = PlayerStatus(HP: 180, MP: 144, Speed: 72, pAtk: 144, mAtk: 0, pDef: 180, mDef: 0)
        let race = Paladin(name: "Hydora", status: status, equipments: [], skills: [], isDie: false)
        let paladin = Player(race: race, imageNamed: "Hydora-2", viewController: nil)
        
        return paladin
    }
    
    //MARK: Get Person Rohan
    public static func getBard() -> Player {
        
        let status = PlayerStatus(HP: 108, MP: 180, Speed: 108, pAtk: 72, mAtk: 0, pDef: 72, mDef: 0)
        let race = Bard(name: "Rohan", status: status, equipments: [], skills: [], isDie: false)
        let bard = Player(race: race, imageNamed: "Rohan-2", viewController: nil)
        
        return bard
    }
    
    //MARK: Get Person Randall
    public static func getMage() -> Player {
        
        let status = PlayerStatus(HP: 72, MP: 180, Speed: 72, pAtk: 180, mAtk: 0, pDef: 108, mDef: 0)
        let race = Mage(name: "Ramdall", status: status, equipments: [], skills: [], isDie: false)
        let mage = Player(race: race, imageNamed: "Ramdall-2", viewController: nil)
        
        return mage
    }
    
    //MARK: Get Person Ylla
    public static func getSwordsman() -> Player {
        
        let status = PlayerStatus(HP: 144, MP: 72, Speed: 180, pAtk: 180, mAtk: 0, pDef: 144, mDef: 0)
        let race = Swordsman(name: "Ylla", status: status, equipments: [], skills: [], isDie: false)
        let swordsman = Player(race: race, imageNamed: "Ylla-2", viewController: nil)
        
        return swordsman
    }
}
