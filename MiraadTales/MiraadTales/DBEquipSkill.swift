//
//  EquipSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 27/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class DBEquipSkill {
    
    private static var equips: [Equip] = []
    private static var skills: [Skill] = []
    
    //MARK: - Get Equipments
    public static func getEquips(ownerRace: PlayersRace) -> [Equip] {
        
        if equips.count == 0 {
            equips = self.createListEquipment()
            skills = self.createListSkills()
            
            self.joinEquipmentsAndSkills(equips, skills: skills)
        }
        
        let equipsRace = equips.filter {
            if $0.baseEquip.ownerRace == ownerRace {
                return true
            }
            return false
        }
        
        return equipsRace
    }
    
    public static func getEquip(nameEquip: String) -> Equip {
        
        if equips.count == 0 {
            equips = self.createListEquipment()
            skills = self.createListSkills()
            
            self.joinEquipmentsAndSkills(equips, skills: skills)
        }
        
        let equip = equips.filter {
            if $0.baseEquip.name.uppercaseString == nameEquip.uppercaseString {
                return true
            }
            
            return false
        }
        
        return equip[0]
    }
    
    //MARK: - Get Skills
    public static func getSkills(ownerRace: PlayersRace) ->  [Skill] {
        
        if skills.count == 0 {
            equips = self.createListEquipment()
            skills = self.createListSkills()
            
            self.joinEquipmentsAndSkills(equips, skills: skills)
        }
        
        let skillsRace = skills.filter {
            if $0.baseSkill.ownerRace == ownerRace {
                return true
            }
            return false
        }
        
        return skillsRace
    }
    
    public static func getSkill(nameSkill: String) -> Skill {
        
        if skills.count == 0 {
            equips = self.createListEquipment()
            skills = self.createListSkills()
            
            self.joinEquipmentsAndSkills(equips, skills: skills)
        }
        
        let skill = skills.filter {
            if $0.baseSkill.name.uppercaseString == nameSkill.uppercaseString {
                return true
            }
            
            return false
        }
        
        return skill[0]
    }
    
    //MARK: - Create List of Skills and Equipments
    private static func createListSkills() -> [Skill] {
        
        //Swordsman class
        let swordsmanSkills = self.createListSkillSwordsman()
        
        //Mage class
        let mageSkills = self.createListSkillMage()
        
        //Bard class
        let bardSkills = self.createListSkillBard()
        
        //Paladin class
        let paladinSkills = self.createListSkillPaladin()
        
        let skills: [Skill] = (swordsmanSkills + mageSkills) + (bardSkills + paladinSkills)
        return skills
    }
    
    private static func createListEquipment() -> [Equip] {
        
        //swordsman class
        let sworsmanEquip = self.createListEquipmentSwordsman()
        
        //mage class
        let mageEquip = self.createListEquipmentMage()
        
        //Bard class
        let bardEquip = self.createListEquipmentBard()
        
        //Paladin class
        let paladinEquip = self.createListEquipmentsPaladin()
        
        let equipments = (sworsmanEquip + mageEquip) + (bardEquip + paladinEquip)
        return equipments
    }
    
    //MARK: - Join Skills and Equipments
    private static func joinEquipmentsAndSkills(equipments: [Equip], skills: [Skill]) {
        
        for var i = 0; i < equipments.count; ++i {
            equipments[i].baseEquip.skill = skills[i]
            skills[i].baseSkill.equip = equipments[i]
        }
    }
    
    //MARK: - Equipments and Skills Swordsman
    private static func createListEquipmentSwordsman() -> [Equip] {
        let statusDualBlades = Status(HP: 0, MP: 0, Speed: 0, pAtk: 90, mAtk: 0, pDef: 0, mDef: 0)
        let dualBlades = BaseEquip(name: "Dual Blades", ownerRace: PlayersRace.Swordsman, status: statusDualBlades, type: ItemType.Weapon, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusGeminiBlades = Status(HP: 0, MP: 0, Speed: 0, pAtk: 250, mAtk: 0, pDef: 0, mDef: 0)
        let geminiBlades = BaseEquip(name: "Gemini Blades", ownerRace: PlayersRace.Swordsman, status: statusGeminiBlades, type: ItemType.Weapon, requiredLevel: 5, skill: nil, unlocked: false)
        
        let statusMirrorBlades = Status(HP: 0, MP: 0, Speed: 0, pAtk: 490, mAtk: 0, pDef: 0, mDef: 0)
        let mirrorBlades = BaseEquip(name: "Mirror Blades", ownerRace: PlayersRace.Swordsman, status: statusMirrorBlades, type: ItemType.Weapon, requiredLevel: 9, skill: nil, unlocked: false)
        
        let statusLeatherArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 72, mDef: 0)
        let leatherArmor = BaseEquip(name: "Leather Armor", ownerRace: PlayersRace.Swordsman, status: statusLeatherArmor, type: ItemType.Armor, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusDuelistArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 162, mDef: 0)
        let duelistArmor = BaseEquip(name: "Duelist Armor", ownerRace: PlayersRace.Swordsman, status: statusDuelistArmor, type: ItemType.Armor, requiredLevel: 4, skill: nil, unlocked: false)
        
        let statusPureArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 338, mDef: 0)
        let pureArmor = BaseEquip(name: "Pure Armor", ownerRace: PlayersRace.Swordsman, status: statusPureArmor, type: ItemType.Armor, requiredLevel: 8, skill: nil, unlocked: false)
        
        let sworsmanEquip = [Equip(imageNamed: "", baseEquip: dualBlades), Equip(imageNamed: "", baseEquip: geminiBlades), Equip(imageNamed: "", baseEquip: mirrorBlades), Equip(imageNamed: "", baseEquip: leatherArmor), Equip(imageNamed: "", baseEquip: duelistArmor), Equip(imageNamed: "", baseEquip: pureArmor)]
        
        return sworsmanEquip
    }
    
    private static func createListSkillSwordsman() -> [Skill] {
        let statusBladeSweep = Status(HP: 0, MP: 0, Speed: 0, pAtk: 90, mAtk: 0, pDef: 0, mDef: 0)
        let bladeSweep = BaseSkill(name: "Blade Sweep", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusBladeSweep, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusCrossCut = Status(HP: 0, MP: 0, Speed: 0, pAtk: 160, mAtk: 0, pDef: 0, mDef: 0)
        let effectCrossCut = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.pDef, percenteEffects: 20)
        let crossCut = BaseSkill(name: "Cross Cut", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusCrossCut, criticalRate: 5, missRate: 5, consumeMana: 24, effect: effectCrossCut, details: "Decrease target defense")
        
        let statusArmorPierce = Status(HP: 0, MP: 0, Speed: 0, pAtk: 250, mAtk: 0, pDef: 0, mDef: 0)
        let effectArmorPierce = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let armorPierce = BaseSkill(name: "Armor Pierce", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusArmorPierce, criticalRate: 2, missRate: 15, consumeMana: 40, effect: effectArmorPierce, details: "")
        
        let statusSpeedBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectSpeedBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.Speed, percenteEffects: 20)
        let speedBoost = BaseSkill(name: "Speed Boost", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusSpeedBoost, criticalRate: 0, missRate: 0, consumeMana: 24, effect: effectSpeedBoost, details: "Increase user speed")
        
        let statusAttackBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectAttackBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 20)
        let attackBoost = BaseSkill(name: "Attack Boost", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusAttackBoost, criticalRate: 0, missRate: 0, consumeMana: 48, effect: effectAttackBoost, details: "Increase user attack")
        
        let statusDefenseBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectDefenseBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pDef, percenteEffects: 20)
        let defenseBoost = BaseSkill(name: "Defense Boost", equip: nil, ownerRace: PlayersRace.Swordsman, status: statusDefenseBoost, criticalRate: 0, missRate: 0, consumeMana: 72, effect: effectDefenseBoost, details: "Increase user defense")
        
        let swordsmanSkills = [Skill(imageNamed: "", baseSkill: bladeSweep), Skill(imageNamed: "", baseSkill: crossCut), Skill(imageNamed: "", baseSkill: armorPierce), Skill(imageNamed: "", baseSkill: speedBoost), Skill(imageNamed: "", baseSkill: attackBoost), Skill(imageNamed: "", baseSkill: defenseBoost)]
        
        return swordsmanSkills
    }
    
    //MARK: - Equipments and Skills Mage
    private static func createListEquipmentMage() -> [Equip] {
        
        let statusWoodenStaff = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 90, pDef: 0, mDef: 0)
        let woodenStaff = BaseEquip(name: "Wooden Staff", ownerRace: PlayersRace.Mage, status: statusWoodenStaff, type: ItemType.Weapon, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusGemStaff = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 250, pDef: 0, mDef: 0)
        let gemStaff = BaseEquip(name: "Gem Staff", ownerRace: PlayersRace.Mage, status: statusGemStaff, type: ItemType.Weapon, requiredLevel: 5, skill: nil, unlocked: false)
        
        let statusTwistedStaff = Status(HP: 0, MP: 0, Speed: 0, pAtk: 196, mAtk: 490, pDef: 0, mDef: 0)
        let twistedStaff = BaseEquip(name: "Twisted Staff", ownerRace: PlayersRace.Mage, status: statusTwistedStaff, type: ItemType.Weapon, requiredLevel: 9, skill: nil, unlocked: false)
        
        let statusCottonTunic = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 54, mDef: 90)
        let cottonTunic = BaseEquip(name: "Cotton Tunic", ownerRace: PlayersRace.Mage, status: statusCottonTunic, type: ItemType.Armor, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusSilkTunic = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 121, mDef: 202)
        let silkTunic = BaseEquip(name: "Silk Tunic", ownerRace: PlayersRace.Mage, status: statusSilkTunic, type: ItemType.Armor, requiredLevel: 4, skill: nil, unlocked: false)
        
        let statusMithrillTunic = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 253, mDef: 422)
        let mithrillTunic = BaseEquip(name: "Mithrill Tunic", ownerRace: PlayersRace.Mage, status: statusMithrillTunic, type: ItemType.Armor, requiredLevel: 8, skill: nil, unlocked: false)
        
        let mageEquip = [Equip(imageNamed: "", baseEquip: woodenStaff), Equip(imageNamed: "", baseEquip: gemStaff), Equip(imageNamed: "", baseEquip: twistedStaff), Equip(imageNamed: "", baseEquip: cottonTunic), Equip(imageNamed: "", baseEquip: silkTunic), Equip(imageNamed: "", baseEquip: mithrillTunic)]
        
        return mageEquip
    }
    
    private static func createListSkillMage() -> [Skill] {
        let statusStarffHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 0, pDef: 0, mDef: 0)
        let starffHit = BaseSkill(name: "Starff Hit", equip: nil, ownerRace: PlayersRace.Mage, status: statusStarffHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusFireBall = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 160, pDef: 0, mDef: 0)
        let fireBall = BaseSkill(name: "Fire Ball", equip: nil, ownerRace: PlayersRace.Mage, status: statusFireBall, criticalRate: 5, missRate: 5, consumeMana: 64, effect: nil, details: "")
        
        let statusEnergyRay = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 150, pDef: 0, mDef: 0)
        let effectEnergyRay = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.mAtk, percenteEffects: 20)
        let energyRay = BaseSkill(name: "Energy Ray", equip: nil, ownerRace: PlayersRace.Mage, status: statusEnergyRay, criticalRate: 2, missRate: 8, consumeMana: 100, effect: effectEnergyRay, details: "Decrease target attack")
        
        let statusLifeSteal = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 122, pDef: 0, mDef: 0)
        let effectLifeSteal = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.HP, percenteEffects: 100)
        let lifeSteal = BaseSkill(name: "Life Steal", equip: nil, ownerRace: PlayersRace.Mage, status: statusLifeSteal, criticalRate: 0, missRate: 8, consumeMana: 24, effect: effectLifeSteal, details: "Restore your HP")
        
        let statusExplosion = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 302, pDef: 0, mDef: 0)
        let effectExplosion = Effect(target: TargetSkill.PartyEnemy, affect: AffectSkill.HP, percenteEffects: 15)
        let explosion = BaseSkill(name: "Explosion", equip: nil, ownerRace: PlayersRace.Mage, status: statusExplosion, criticalRate: 2, missRate: 8, consumeMana: 120, effect: effectExplosion, details: "Decrease party hp")
        
        let statusPetrifyRay = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 490, pDef: 0, mDef: 0)
        let effectPetrifyRay = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let petrifyRay = BaseSkill(name: "Petrify Ray", equip: nil, ownerRace: PlayersRace.Mage, status: statusPetrifyRay, criticalRate: 0, missRate: 15, consumeMana: 196, effect: effectPetrifyRay, details: "")
        
        let mageSkills = [Skill(imageNamed: "", baseSkill: starffHit), Skill(imageNamed: "", baseSkill: fireBall), Skill(imageNamed: "", baseSkill: energyRay), Skill(imageNamed: "", baseSkill: lifeSteal), Skill(imageNamed: "", baseSkill: explosion), Skill(imageNamed: "", baseSkill: petrifyRay)]
        
        return mageSkills
    }
    
    //MARK: - Equipments and Skills Bard
    private static func createListEquipmentBard() -> [Equip] {
        let statusOldLute = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 54, pDef: 0, mDef: 0)
        let oldLute = BaseEquip(name: "Old lute", ownerRace: PlayersRace.Bard, status: statusOldLute, type: ItemType.Weapon, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusClassicGuitar = Status(HP: 0, MP: 0, Speed: 0, pAtk: 100, mAtk: 150, pDef: 0, mDef: 0)
        let classicGuitar = BaseEquip(name: "Classi Guitar", ownerRace: PlayersRace.Bard, status: statusClassicGuitar, type: ItemType.Weapon, requiredLevel: 5, skill: nil, unlocked: false)
        
        let statusSilverHarp = Status(HP: 0, MP: 0, Speed: 0, pAtk: 196, mAtk: 294, pDef: 0, mDef: 0)
        let silverHarp = BaseEquip(name: "Silver Harp", ownerRace: PlayersRace.Bard, status: statusSilverHarp, type: ItemType.Weapon, requiredLevel: 9, skill: nil, unlocked: false)
        
        let statusTroubadourClothes = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 36, mDef: 54)
        let troubadourClothes = BaseEquip(name: "Troubadour Clothes", ownerRace: PlayersRace.Bard, status: statusTroubadourClothes, type: ItemType.Armor, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusMusicianClothes = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 81, mDef: 121)
        let musicianClothes = BaseEquip(name: "Musician Clothes", ownerRace: PlayersRace.Bard, status: statusMusicianClothes, type: ItemType.Armor, requiredLevel: 4, skill: nil, unlocked: false)
        
        let statusBardClothes = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 169, mDef: 253)
        let bardClothes = BaseEquip(name: "Bard Clothes", ownerRace: PlayersRace.Bard, status: statusBardClothes, type: ItemType.Armor, requiredLevel: 8, skill: nil, unlocked: false)
        
        let bardEquip = [Equip(imageNamed: "", baseEquip: oldLute), Equip(imageNamed: "", baseEquip: classicGuitar), Equip(imageNamed: "", baseEquip: silverHarp), Equip(imageNamed: "", baseEquip: troubadourClothes), Equip(imageNamed: "", baseEquip: musicianClothes), Equip(imageNamed: "", baseEquip: bardClothes)]
        
        return bardEquip
    }
    
    private static func createListSkillBard() -> [Skill] {
        let statusInstrumentHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 0, pDef: 0, mDef: 0)
        let instrumentHit = BaseSkill(name: "Instrument Hit", equip: nil, ownerRace: PlayersRace.Bard, status: statusInstrumentHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusPowerChord = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 96, pDef: 0, mDef: 0)
        let powerChord = BaseSkill(name: "Power Chord", equip: nil, ownerRace: PlayersRace.Bard, status: statusPowerChord, criticalRate: 5, missRate: 5, consumeMana: 64, effect: nil, details: "")
        
        let statusDarkSonata = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 294, pDef: 0, mDef: 0)
        let effectDarkSonata = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let darkSonata = BaseSkill(name: "Dark Sonata", equip: nil, ownerRace: PlayersRace.Bard, status: statusDarkSonata, criticalRate: 0, missRate: 15, consumeMana: 196, effect: effectDarkSonata, details: "")
        
        let statusHasteSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectHasteSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.Speed, percenteEffects: 20)
        let hasteSong = BaseSkill(name: "Haste Song", equip: nil, ownerRace: PlayersRace.Bard, status: statusHasteSong, criticalRate: 0, missRate: 0, consumeMana: 48, effect: effectHasteSong, details: "Increase target speed")
        
        let statusDefenseSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectDefenseSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pDef, percenteEffects: 20)
        let defenseSong = BaseSkill(name: "Defense Song", equip: nil, ownerRace: PlayersRace.Bard, status: statusDefenseSong, criticalRate: 0, missRate: 0, consumeMana: 121, effect: effectDefenseSong, details: "Increase target speed")
        
        let statusAttackSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectAttackSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 20)
        let attackSong = BaseSkill(name: "Attack Song", equip: nil, ownerRace: PlayersRace.Bard, status: statusAttackSong, criticalRate: 0, missRate: 0, consumeMana: 100, effect: effectAttackSong, details: "Increase target attack")
        
        let bardSkills = [Skill(imageNamed: "", baseSkill: instrumentHit), Skill(imageNamed: "", baseSkill: powerChord), Skill(imageNamed: "", baseSkill: darkSonata), Skill(imageNamed: "", baseSkill: hasteSong), Skill(imageNamed: "", baseSkill: defenseSong), Skill(imageNamed: "", baseSkill: attackSong)]
        
        return bardSkills
    }
    
    //MARK: - Equipments and Skills Paladin
    private static func createListEquipmentsPaladin() -> [Equip] {
        let statusSledgehammer = Status(HP: 0, MP: 0, Speed: 0, pAtk: 72, mAtk: 54, pDef: 0, mDef: 0)
        let sledgehammer = BaseEquip(name: "Sledgehammer", ownerRace: PlayersRace.Paladin, status: statusSledgehammer, type: ItemType.Weapon, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusWarhammer = Status(HP: 0, MP: 0, Speed: 0, pAtk: 200, mAtk: 150, pDef: 0, mDef: 0)
        let warhammer = BaseEquip(name: "Warhammer", ownerRace: PlayersRace.Paladin, status: statusWarhammer, type: ItemType.Weapon, requiredLevel: 5, skill: nil, unlocked: false)
        
        let statusPunishment = Status(HP: 0, MP: 0, Speed: 0, pAtk: 392, mAtk: 294, pDef: 0, mDef: 0)
        let punishment = BaseEquip(name: "Punishment", ownerRace: PlayersRace.Paladin, status: statusPunishment, type: ItemType.Weapon, requiredLevel: 9, skill: nil, unlocked: false)
        
        let statusHeavyArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 90, mDef: 54)
        let heavyArmor = BaseEquip(name: "Heavy Armor", ownerRace: PlayersRace.Paladin, status: statusHeavyArmor, type: ItemType.Armor, requiredLevel: 0, skill: nil, unlocked: false)
        
        let statusPaladinArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 202, mDef: 121)
        let paladinArmor = BaseEquip(name: "Paladin Armor", ownerRace: PlayersRace.Paladin, status: statusPaladinArmor, type: ItemType.Armor, requiredLevel: 4, skill: nil, unlocked: false)
        
        let statusCorruptedArmor = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 422, mDef: 253)
        let corruptedArmor = BaseEquip(name: "Corrupted Armor", ownerRace: PlayersRace.Paladin, status: statusCorruptedArmor, type: ItemType.Armor, requiredLevel: 8, skill: nil, unlocked: false)
        
        let paladinEquip = [Equip(imageNamed: "", baseEquip: sledgehammer), Equip(imageNamed: "", baseEquip: warhammer), Equip(imageNamed: "", baseEquip: punishment), Equip(imageNamed: "", baseEquip: heavyArmor), Equip(imageNamed: "", baseEquip: paladinArmor), Equip(imageNamed: "", baseEquip: corruptedArmor)]
        
        return paladinEquip
    }
    
    private static func createListSkillPaladin() -> [Skill] {
        let statusHammerHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 72, mAtk: 0, pDef: 0, mDef: 0)
        let hammerHit = BaseSkill(name: "Hammer Hit", equip: nil, ownerRace: PlayersRace.Paladin, status: statusHammerHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusHolyLight = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 91, pDef: 0, mDef: 0)
        let holyLight = BaseSkill(name: "Holy Light", equip: nil, ownerRace: PlayersRace.Paladin, status: statusHolyLight, criticalRate: 5, missRate: 5, consumeMana: 51, effect: nil, details: "")
        
        let statusPunish = Status(HP: 0, MP: 0, Speed: 0, pAtk: 392, mAtk: 0, pDef: 0, mDef: 0)
        let effectPunish = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let punish = BaseSkill(name: "Punish", equip: nil, ownerRace: PlayersRace.Paladin, status: statusPunish, criticalRate: 0, missRate: 15, consumeMana: 156, effect: effectPunish, details: "")
        
        let statusHeal = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectHeal = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.HP, percenteEffects: 20)
        let heal = BaseSkill(name: "Heal", equip: nil, ownerRace: PlayersRace.Paladin, status: statusHeal, criticalRate: 0, missRate: 8, consumeMana: 62, effect: effectHeal, details: "Restore target hp")
        
        let statusPurification = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectPurification = Effect(target: TargetSkill.SingleEnemy, affect: .HP, percenteEffects: 0)
        let purification = BaseSkill(name: "Purification", equip: nil, ownerRace: PlayersRace.Paladin, status: statusPurification, criticalRate: 0, missRate: 0, consumeMana: 38, effect: effectPurification, details: "Remove target debuffs")
        
        let statusWarcry = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectWarcry = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 15)
        let warcry = BaseSkill(name: "Warcry", equip: nil, ownerRace: PlayersRace.Paladin, status: statusWarcry, criticalRate: 0, missRate: 0, consumeMana: 96, effect: effectWarcry, details: "Increase user Attack")
        
        let paladinSkills = [Skill(imageNamed: "", baseSkill: hammerHit), Skill(imageNamed: "", baseSkill: holyLight), Skill(imageNamed: "", baseSkill: punish), Skill(imageNamed: "", baseSkill: heal), Skill(imageNamed: "", baseSkill: purification), Skill(imageNamed: "", baseSkill: warcry)]
        
        return paladinSkills
    }
}