//
//  BaseSkill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseSkill: NSObject {

    public let name: String
    public let expendMP: Int
    public let ownerRace: PlayersRace
    public let requiredLvl: Int
    public let effects: String
    
    public init(name:String, expendMP: Int,ownerRace:PlayersRace, requiredLvl:Int,effects: String) {
        self.name = name
        self.expendMP = expendMP
        self.ownerRace = ownerRace
        self.requiredLvl = requiredLvl
        self.effects = effects
    }
}
