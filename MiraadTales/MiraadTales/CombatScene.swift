//
//  CombatScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 22/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CombatScene: SKScene {

    var players: [Player] = []
    var enimies: [NSObject] = []
    
    override func didMoveToView(view: SKView) {
        
        let skInfoPlayers = self.childNodeWithName("SKInfoPlayers")!
        skInfoPlayers.alpha = 0.7
        
        let skLine = self.childNodeWithName("SKLine")!
        skLine.alpha = 1
        
    }
    
    //MARK: - Touch event's
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    
    //MARK: - Update method
    override func update(currentTime: NSTimeInterval) {
        
    }
}
