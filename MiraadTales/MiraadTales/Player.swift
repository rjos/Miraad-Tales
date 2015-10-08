//
//  Player.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Player: SKSpriteNode {
    
    public let race: BaseRace
    
    public init(race: BaseRace, imageNamed: String) {
        self.race = race
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.redColor(), size: texture.size())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(currentTime: CFTimeInterval) {
        
    }
}
