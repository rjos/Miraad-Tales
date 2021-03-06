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
            }else if nameTarget == "Bellatrix"{
                enemy = self.getBellatrix()!
            }else if nameTarget == "Bones" {
                enemy = self.getAngryChicken()!
            }else if nameTarget == "Buggy" {
                enemy = self.getChickKing()!
            }
            
            enemies.append(enemy)
        }
        
        return enemies
    }
    
    //MARK: Enemy Chaser Wolf
    private static func getChaserWolf() -> Enemy? {
        
        let status = PlayerStatus(HP: 400, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        
        let skills = getSkillChaserWolf()
        
        let base = BaseEnemy(name: "Chaser Wolf", status: status, equipments: [], skills: skills, isDie: false, typeEnemy: TypeEnemy.ChaserWolf)
        
        let chaserWolf = Enemy(imageNamed: "Zumbi-5", race: base)
        chaserWolf.name = "Zumbi"
        
        return chaserWolf
    }
    
    private static func getSkillChaserWolf() -> [Skill] {
        
        let statusArranhao = Status(HP: 0, MP: 0, Speed: 0, pAtk: 300, mAtk: 0, pDef: 0, mDef: 0)
        let arranhao = BaseSkill(name: "Arranhão", fantasyName: "Arranhao", equip: nil, ownerRace: PlayersRace.Bard, status: statusArranhao, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        let statusMordida = Status(HP: 0, MP: 0, Speed: 0, pAtk: 300, mAtk: 0, pDef: 0, mDef: 0)
        let mordida = BaseSkill(name: "Mordida", fantasyName: "Mordida", equip: nil, ownerRace: PlayersRace.Bard, status: statusMordida, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        return [Skill(imageNamed: "", baseSkill: arranhao), Skill(imageNamed: "", baseSkill: mordida)]
    }
    
    private static func getEquipmentChaserWolf() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Angry Chicken
    private static func getAngryChicken() -> Enemy? {
        let status = PlayerStatus(HP: 400, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        
        let skills = getSkillAngryChicken()
        
        let base = BaseEnemy(name: "Bones", status: status, equipments: [], skills: skills, isDie: false, typeEnemy: TypeEnemy.AngryChicken)
        
        let bones = Enemy(imageNamed: "Bones-5", race: base)
        bones.name = "Bones"
        
        return bones
    }
    
    private static func getSkillAngryChicken() -> [Skill] {
        
        let statusOssada = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let ossada = BaseSkill(name: "Ossada", fantasyName: "Ossada", equip: nil, ownerRace: PlayersRace.Bard, status: statusOssada, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        return [Skill(imageNamed: "", baseSkill: ossada)]
    }
    
    private static func getEquipmentAngryChicken() -> [Equip] {
        return []
    }
    
    //MARK: Enemy Chick King
    private static func getChickKing() -> Enemy? {
        let status = PlayerStatus(HP: 400, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        
        let skills = getSkillChickKing()
        
        let base = BaseEnemy(name: "Buggy", status: status, equipments: [], skills: skills, isDie: false, typeEnemy: TypeEnemy.ChickKing)
        
        let buggy = Enemy(imageNamed: "Buggy-5", race: base)
        buggy.name = "Buggy"
        
        return buggy
    }
    
    private static func getSkillChickKing() -> [Skill] {

        let statusDrenar = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let drenar = BaseSkill(name: "Drenar", fantasyName: "Drenar", equip: nil, ownerRace: PlayersRace.Bard, status: statusDrenar, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        let statusMordida = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let mordida = BaseSkill(name: "Mordida", fantasyName: "Mordida Buggy", equip: nil, ownerRace: PlayersRace.Bard, status: statusMordida, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        return [Skill(imageNamed: "", baseSkill: mordida), Skill(imageNamed: "", baseSkill: drenar)]
        
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
        let status = PlayerStatus(HP: 400, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        
        let skills = getSkillBellatrix()
        
        let base = BaseEnemy(name: "Bellatrix", status: status, equipments: [], skills: skills, isDie: false, typeEnemy: TypeEnemy.Bellatrix)
        
        let bellatrix = Enemy(imageNamed: "Bellatrix-5", race: base)
        bellatrix.name = "Bellatrix"
        
        return bellatrix
    }
    
    private static func getSkillBellatrix() -> [Skill] {
        let statusFireBall = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let fireBall = BaseSkill(name: "Fire Ball", fantasyName: "Fire ball", equip: nil, ownerRace: PlayersRace.Bard, status: statusFireBall, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        let statusPoisonSmoke = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 0, pDef: 0, mDef: 0)
        let poisonSmoke = BaseSkill(name: "Poison Smoke", fantasyName: "Poison", equip: nil, ownerRace: PlayersRace.Bard, status: statusPoisonSmoke, criticalRate: 0, missRate: 0, consumeMana: 0, effect: nil, details: "")
        
        return [Skill(imageNamed: "", baseSkill: fireBall), Skill(imageNamed: "", baseSkill: poisonSmoke)]
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