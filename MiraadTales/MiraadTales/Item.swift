//
//  Item.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Item: SKSpriteNode {
    
    public let item: BaseItem
    
    public init(item: BaseItem, imageNamed: String) {
        self.item = item
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.greenColor(), size: texture.size())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
