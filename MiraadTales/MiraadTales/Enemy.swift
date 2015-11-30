//
//  Ememy.swift
//  MiraadTales
//
//  Created by Rodolfo José on 27/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Enemy: SKSpriteNode {
    
    public let race: BaseEnemy
    
    public init (imageNamed: String, race: BaseEnemy) {
        self.race = race
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.blackColor(), size: texture.size())
        
        texture.filteringMode = .Nearest
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
