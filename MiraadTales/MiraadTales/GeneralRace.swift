//
//  GeneralRace.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class GeneralRace: NSObject {

    public let name: String
    public let status: PlayerStatus
    public var equipments: [Item]
    public var skills: [BaseSkill]
    
    public init(name: String, status: PlayerStatus, equipments: [Item], skills: [BaseSkill]) {
        self.name = name
        self.status = status
        self.equipments = equipments
        self.skills = skills
    }
}
