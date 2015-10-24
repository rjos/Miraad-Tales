//
//  Skill.swift
//  MiraadTales
//
//  Created by Rodolfo José on 24/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Skill: SKSpriteNode {

    public let baseSkill: BaseSkill
    
    public init(imageNamed: String, baseSkill: BaseSkill) {
        
        let texture = SKTexture(imageNamed: imageNamed)
        self.baseSkill = baseSkill
        super.init(texture: texture, color: UIColor.redColor(), size: texture.size())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func increaseAtk() -> Int {
        return self.baseSkill.increaseAtk()
    }
    
    public func increaseDef() -> Int {
        return self.baseSkill.increaseDef()
    }
    
    public func increaseSpeed() -> Int {
        return self.baseSkill.increaseSpeed()
    }
    
    public func calculateCriticalRate() {
        
    }
    
    public func calculateMissRate() {
        
    }
}
