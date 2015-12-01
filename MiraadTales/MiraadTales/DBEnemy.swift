//
//  DBEnemy.swift
//  MiraadTales
//
//  Created by Rodolfo José on 09/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import Foundation

public class DBEnemy {
    
    public static func getEnemy(nameTarget: String, qtdade: Int) -> [Enemy] {
     
        var enemies: [Enemy] = []
        var enemy: Enemy! = nil
        
        for var i = 0; i < qtdade; ++i {
            
            if nameTarget == "Zumbi" {
                enemy = self.getChaserWolf()!
            }
            
            enemies.append(enemy)
        }
        
        return enemies
    }
    
    //MARK: Enemy Chaser Wolf
    private static func getChaserWolf() -> Enemy? {
        
        let status = PlayerStatus(HP: 400, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        
        let skills = getSkillChaserWolf()
        
        let base = BaseEnemy(name: "Chaser Wolf", status: status, equipments: [], skills: skills, isDie: false, typeEnemy: TypeEnemy.AngryChicken)
        
        let chaserWolf = Enemy(imageNamed: "Zumbi-5", race: base)
        chaserWolf.name = "Zumbi"
        
        return chaserWolf
    }
    
    private static func getSkillChaserWolf() -> [Skill] {
        
        let statusArranhao = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let arranhao = BaseSkill(name: "Arranhão", fantasyName: "Arranhao", equip: nil, ownerRace: PlayersRace.Bard, status: statusArranhao, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        let statusMordida = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let mordida = BaseSkill(name: "Mordida", fantasyName: "Mordida", equip: nil, ownerRace: PlayersRace.Bard, status: statusArranhao, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        return [Skill(imageNamed: "", baseSkill: arranhao), Skill(imageNamed: "", baseSkill: mordida)]
    }
    
    private static func getEquipmentChaserWolf() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Angry Chicken
    private static func getAngryChicken() -> Enemy? {
        return nil
    }
    
    private static func getSkillAngryChicken() -> [Skill] {
        return []
    }
    
    private static func getEquipmentAngryChicken() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Chick King
    private static func getChickKing() -> Enemy? {
        return nil
    }
    
    private static func getSkillChickKing() -> [Skill] {
        return []
    }
    
    private static func getEquipmentChickKing() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Sea Newt
    private static func getSeaNewt() -> Enemy? {
        return nil
    }
    
    private static func getSkillSeaNewt() -> [Enemy] {
        return []
    }
    
    private static func getEquipmentSeaNewt() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Giant Roach
    private static func getGiantRoach() -> Enemy? {
        return nil
    }
    
    private static func getSkillGiantRoach() -> [Skill] {
        return []
    }
    
    private static func getEquipmentGiantRoach() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Miner Mole
    private static func getMinerMole() -> Enemy? {
        return nil
    }
    
    private static func getSkillMinerMole() -> [Skill] {
        return []
    }
    
    private static func getEquipmentMinerMole() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Frost Illusion
    private static func getFrostIllusion() -> Enemy? {
        return nil
    }
    
    private static func getSkillFrostIllusion() -> [Skill] {
        return []
    }
    
    private static func getEquipmentFrostIllusion() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Bellatrix and Bellatrix (2nd battle)
    private static func getBellatrix() -> Enemy? {
        return nil
    }
    
    private static func getSkillBellatrix() -> [Skill] {
        return []
    }
    
    private static func getSkillBellatrixAgain() -> [Skill] {
        return []
    }
    
    private static func getEquipmentBellatrix() -> [Equip] {
        return []
    }
    
    private static func getEquipmentBellatrixAgain() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Tormented Spirit
    private static func getTormentedSpirit() -> Enemy? {
        return nil
    }
    
    private static func getSkillTormentedSpirit() -> [Skill] {
        return []
    }
    
    private static func getEquipTormentedSpirit() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Blaze Ophidian
    private static func getBlazeOphidian() -> Enemy? {
        return nil
    }
    
    private static func getSkillBlazeOphidian() -> [Skill] {
        return []
    }
    
    private static func getEquipmentBlazeOphidian() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Aemon
    private static func getAemon() -> Enemy? {
        return nil
    }
    
    private static func getSkillAemon() -> [Skill] {
        return []
    }
    
    private static func getEquipmentAemon() -> [Equip] {
        return []
    }
}