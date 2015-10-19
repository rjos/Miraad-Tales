//
//  Button.swift
//  MiraadTales
//
//  Created by Rodolfo José on 19/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Button: SKNode {

    private var background: SKSpriteNode
    private var item: SKSpriteNode
    
    public init(backgroundImage: String, itemImage: String) {
        
        self.background = SKSpriteNode(imageNamed: backgroundImage)
        self.background.alpha = 0.5
        
        self.item = SKSpriteNode(imageNamed: itemImage)
        self.item.alpha = 0.5
        
        super.init()
        
        self.addChild(self.background)
        self.addChild(self.item)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.background.alpha = 0.8
        self.item.alpha = 0.8
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.background.alpha = 0.5
        self.item.alpha = 0.5
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.background.alpha = 0.5
        self.item.alpha = 0.5
    }
}
