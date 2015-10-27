//
//  EquipSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 27/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class EquipSkill {
    
    private var equips: [Equip] = []
    private var skills: [Skill] = []
    
    private func createListSkills() -> [Skill] {
        
        //Swordsman class
        let statusBladeSweep = Status(HP: 0, MP: 0, Speed: 0, pAtk: 90, mAtk: 0, pDef: 0, mDef: 0)
        let bladeSweep = BaseSkill(name: "Blade Sweep", equip: nil, status: statusBladeSweep, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusCrossCut = Status(HP: 0, MP: 0, Speed: 0, pAtk: 160, mAtk: 0, pDef: 0, mDef: 0)
        let effectCrossCut = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.pDef, percenteEffects: 20)
        let crossCut = BaseSkill(name: "Cross Cut", equip: nil, status: statusCrossCut, criticalRate: 5, missRate: 5, consumeMana: 24, effect: effectCrossCut, details: "Decrease target defense")
        
        let statusArmorPierce = Status(HP: 0, MP: 0, Speed: 0, pAtk: 250, mAtk: 0, pDef: 0, mDef: 0)
        let effectArmorPierce = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let armorPierce = BaseSkill(name: "Armor Pierce", equip: nil, status: statusArmorPierce, criticalRate: 2, missRate: 15, consumeMana: 40, effect: effectArmorPierce, details: "")
        
        let statusSpeedBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectSpeedBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.Speed, percenteEffects: 20)
        let speedBoost = BaseSkill(name: "Speed Boost", equip: nil, status: statusSpeedBoost, criticalRate: 0, missRate: 0, consumeMana: 24, effect: effectSpeedBoost, details: "Increase user speed")
        
        let statusAttackBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectAttackBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 20)
        let attackBoost = BaseSkill(name: "Attack Boost", equip: nil, status: statusAttackBoost, criticalRate: 0, missRate: 0, consumeMana: 48, effect: effectAttackBoost, details: "Increase user attack")
        
        let statusDefenseBoost = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectDefenseBoost = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pDef, percenteEffects: 20)
        let defenseBoost = BaseSkill(name: "Defense Boost", equip: nil, status: statusDefenseBoost, criticalRate: 0, missRate: 0, consumeMana: 72, effect: effectDefenseBoost, details: "Increase user defense")
        
        let swordsmanSkills = [Skill(imageNamed: "", baseSkill: bladeSweep), Skill(imageNamed: "", baseSkill: crossCut), Skill(imageNamed: "", baseSkill: armorPierce), Skill(imageNamed: "", baseSkill: speedBoost), Skill(imageNamed: "", baseSkill: attackBoost), Skill(imageNamed: "", baseSkill: defenseBoost)]
        
        //Mage class
        let statusStarffHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 0, pDef: 0, mDef: 0)
        let starffHit = BaseSkill(name: "Starff Hit", equip: nil, status: statusStarffHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusFireBall = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 160, pDef: 0, mDef: 0)
        let fireBall = BaseSkill(name: "Fire Ball", equip: nil, status: statusFireBall, criticalRate: 5, missRate: 5, consumeMana: 64, effect: nil, details: "")
        
        let statusEnergyRay = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 150, pDef: 0, mDef: 0)
        let effectEnergyRay = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.mAtk, percenteEffects: 20)
        let energyRay = BaseSkill(name: "Energy Ray", equip: nil, status: statusEnergyRay, criticalRate: 2, missRate: 8, consumeMana: 100, effect: effectEnergyRay, details: "Decrease target attack")
        
        let statusLifeSteal = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 122, pDef: 0, mDef: 0)
        let effectLifeSteal = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.HP, percenteEffects: 100)
        let lifeSteal = BaseSkill(name: "Life Steal", equip: nil, status: statusLifeSteal, criticalRate: 0, missRate: 8, consumeMana: 24, effect: effectLifeSteal, details: "Restore your HP")
        
        let statusExplosion = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 302, pDef: 0, mDef: 0)
        let effectExplosion = Effect(target: TargetSkill.PartyEnemy, affect: AffectSkill.HP, percenteEffects: 15)
        let explosion = BaseSkill(name: "Explosion", equip: nil, status: statusExplosion, criticalRate: 2, missRate: 8, consumeMana: 120, effect: effectExplosion, details: "Decrease party hp")
        
        let statusPetrifyRay = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 490, pDef: 0, mDef: 0)
        let effectPetrifyRay = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let petrifyRay = BaseSkill(name: "Petrify Ray", equip: nil, status: statusPetrifyRay, criticalRate: 0, missRate: 15, consumeMana: 196, effect: effectPetrifyRay, details: "")
        
        let mageSkills = [Skill(imageNamed: "", baseSkill: starffHit), Skill(imageNamed: "", baseSkill: fireBall), Skill(imageNamed: "", baseSkill: energyRay), Skill(imageNamed: "", baseSkill: lifeSteal), Skill(imageNamed: "", baseSkill: explosion), Skill(imageNamed: "", baseSkill: petrifyRay)]
        
        //Bard class
        let statusInstrumentHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 36, mAtk: 0, pDef: 0, mDef: 0)
        let instrumentHit = BaseSkill(name: "Instrument Hit", equip: nil, status: statusInstrumentHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusPowerChord = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 96, pDef: 0, mDef: 0)
        let powerChord = BaseSkill(name: "Power Chord", equip: nil, status: statusPowerChord, criticalRate: 5, missRate: 5, consumeMana: 64, effect: nil, details: "")
        
        let statusDarkSonata = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 294, pDef: 0, mDef: 0)
        let effectDarkSonata = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let darkSonata = BaseSkill(name: "Dark Sonata", equip: nil, status: statusDarkSonata, criticalRate: 0, missRate: 15, consumeMana: 196, effect: effectDarkSonata, details: "")
        
        let statusHasteSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectHasteSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.Speed, percenteEffects: 20)
        let hasteSong = BaseSkill(name: "Haste Song", equip: nil, status: statusHasteSong, criticalRate: 0, missRate: 0, consumeMana: 48, effect: effectHasteSong, details: "Increase target speed")
        
        let statusDefenseSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectDefenseSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pDef, percenteEffects: 20)
        let defenseSong = BaseSkill(name: "Defense Song", equip: nil, status: statusDefenseSong, criticalRate: 0, missRate: 0, consumeMana: 121, effect: effectDefenseSong, details: "Increase target speed")
        
        let statusAttackSong = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectAttackSong = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 20)
        let attackSong = BaseSkill(name: "Attack Song", equip: nil, status: statusAttackSong, criticalRate: 0, missRate: 0, consumeMana: 100, effect: effectAttackSong, details: "Increase target attack")
        
        let bardSkills = [Skill(imageNamed: "", baseSkill: instrumentHit), Skill(imageNamed: "", baseSkill: powerChord), Skill(imageNamed: "", baseSkill: darkSonata), Skill(imageNamed: "", baseSkill: hasteSong), Skill(imageNamed: "", baseSkill: defenseSong), Skill(imageNamed: "", baseSkill: attackSong)]
        
        //Paladin class
        let statusHammerHit = Status(HP: 0, MP: 0, Speed: 0, pAtk: 72, mAtk: 0, pDef: 0, mDef: 0)
        let hammerHit = BaseSkill(name: "Hammer Hit", equip: nil, status: statusHammerHit, criticalRate: 8, missRate: 2, consumeMana: 0, effect: nil, details: "")
        
        let statusHolyLight = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 91, pDef: 0, mDef: 0)
        let holyLight = BaseSkill(name: "Holy Light", equip: nil, status: statusHolyLight, criticalRate: 5, missRate: 5, consumeMana: 51, effect: nil, details: "")
        
        let statusPunish = Status(HP: 0, MP: 0, Speed: 0, pAtk: 392, mAtk: 0, pDef: 0, mDef: 0)
        let effectPunish = Effect(target: TargetSkill.SingleEnemy, affect: AffectSkill.HP, percenteEffects: 100)
        let punish = BaseSkill(name: "Punish", equip: nil, status: statusPunish, criticalRate: 0, missRate: 15, consumeMana: 156, effect: effectPunish, details: "")
        
        let statusHeal = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectHeal = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.HP, percenteEffects: 20)
        let heal = BaseSkill(name: "Heal", equip: nil, status: statusHeal, criticalRate: 0, missRate: 8, consumeMana: 62, effect: effectHeal, details: "Restore target hp")
        
        let statusPurification = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectPurification = Effect(target: TargetSkill.SingleEnemy, affect: .HP, percenteEffects: 0)
        let purification = BaseSkill(name: "Purification", equip: nil, status: statusPurification, criticalRate: 0, missRate: 0, consumeMana: 38, effect: effectPurification, details: "Remove target debuffs")
        
        let statusWarcry = Status(HP: 0, MP: 0, Speed: 0, pAtk: 0, mAtk: 0, pDef: 0, mDef: 0)
        let effectWarcry = Effect(target: TargetSkill.SinglePlayer, affect: AffectSkill.pAtk, percenteEffects: 15)
        let warcry = BaseSkill(name: "Warcry", equip: nil, status: statusWarcry, criticalRate: 0, missRate: 0, consumeMana: 96, effect: effectWarcry, details: "Increase user Attack")
        
        let paladinSkills = [Skill(imageNamed: "", baseSkill: hammerHit), Skill(imageNamed: "", baseSkill: holyLight), Skill(imageNamed: "", baseSkill: punish), Skill(imageNamed: "", baseSkill: heal), Skill(imageNamed: "", baseSkill: purification), Skill(imageNamed: "", baseSkill: warcry)]
        
        let skills: [Skill] = (swordsmanSkills + mageSkills) + (bardSkills + paladinSkills)
        return skills
    }
    
    private func createListEquipment() -> [Equip] {
        
        //swordsman class
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
        
        let sworsmanEquip = [dualBlades, geminiBlades, mirrorBlades, leatherArmor, duelistArmor, pureArmor]
        
        //mage class
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
        
        let mageEquip = [woodenStaff, gemStaff, twistedStaff, cottonTunic, silkTunic, mithrillTunic]
        
    }
}
