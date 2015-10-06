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
    public let ownerRace: PlayersRace
    public let effects: String
    
    public init(name:String, ownerRace:PlayersRace, effects: String) {
        self.name = name
        self.ownerRace = ownerRace
        self.effects = effects
    }
}
