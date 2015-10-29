//
//  EquipmentsMenu.swift
//  MiraadTales
//
//  Created by Rodolfo José on 29/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class EquipmentsMenu: SKNode {
    
    private var btnClose: SKSpriteNode
    private var players: [Player]
    
    public init(players: [Player], size: CGSize) {
        
        self.players = players
        
        self.btnClose = SKSpriteNode(imageNamed: "")
        self.btnClose.name = "btnClose"
        
        super.init()
        
        //Escurecendo o fundo
        let shadowBG = SKSpriteNode(color: UIColor.blackColor(), size: size)
        shadowBG.name = "shadow"
        shadowBG.alpha = 0.0
        shadowBG.zPosition = 1
        
        self.addChild(shadowBG)
        
        //Bg do menu de iteração
        let bg = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: size.width * 0.75, height: size.height * 0.75))
        bg.position = CGPointZero
        bg.zPosition = 2
        
        self.addChild(bg)
        
    }

    public func t() {
        let node = self.childNodeWithName("shadow")!
        node.alpha = 0.6
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    
    public func update(currentTime: NSTimeInterval) {
        
    }
}
