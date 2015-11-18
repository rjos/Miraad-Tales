//
//  Item.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Equip: SKSpriteNode {
    
    public let baseEquip: BaseEquip
    
    public init(imageNamed: String, baseEquip: BaseEquip) {
        self.baseEquip = baseEquip
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.blackColor(), size: texture.size())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
