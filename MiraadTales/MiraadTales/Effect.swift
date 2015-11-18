//
//  Effect.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Effect {
    
    public let target: TargetSkill
    public let affect: AffectSkill
    public let percenteEffects: Int
    
    public init(target: TargetSkill, affect: AffectSkill, percenteEffects: Int) {
        self.target = target
        self.affect = affect
        self.percenteEffects = percenteEffects
    }
}

public enum TargetSkill: String {
    
    case SinglePlayer = "TargetSinglePlayer"
    case SingleEnemy = "TargetSingleEnemy"
    case PartyPlayer = "TargetPartyPlayer"
    case PartyEnemy = "TargetPartyEnemy"
}

public enum AffectSkill: String {
    
    case HP = "AffectHP"
    case MP = "AffectMP"
    case pAtk = "AffectPAtk"
    case mAtk = "AffectMAtk"
    case pDef = "AffectPDef"
    case mDef = "AffectMDef"
    case Speed = "AffectSpeed"
}

