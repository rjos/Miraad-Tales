//
//  Enemy.swift
//  MiraadTales
//
//  Created by Rodolfo José on 27/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseEnemy: BaseRace {
    
    public let typeEnemy: TypeEnemy
    
    public init(name: String, status: PlayerStatus, equipments: [Equip], skills: [Skill], isDie: Bool, typeEnemy: TypeEnemy) {
        self.typeEnemy = typeEnemy
        super.init(name: name, status: status, equipments: equipments, skills: skills, isDie: isDie)
    }
}
