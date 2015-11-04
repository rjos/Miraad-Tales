//
//  CombatScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 22/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CombatScene: SKScene {

    var players: [Player]!
    var enimies: [NSObject]!
    
    private var combatScene: SKNode!
    private var skLifePlayers: SKNode!
    private var skSkillPlayers: SKNode!
    private var skDescription: SKNode!
    
    override func didMoveToView(view: SKView) {
        
        combatScene = self.childNodeWithName("SKCombatScene")!
        let skInfoPlayers = combatScene.childNodeWithName("SKInfoPlayers")!
        skInfoPlayers.alpha = 0.7
        
        self.skLifePlayers = skInfoPlayers.childNodeWithName("SKLifePlayers")!
        self.skSkillPlayers = skInfoPlayers.childNodeWithName("SKSkillPlayers")!
        self.skDescription = skInfoPlayers.childNodeWithName("SKDescription")!

        //Set positions players and enimies in the combat
        self.setPlayersPositions(self.players!)
//        self.setEnimiesPositions(self.enimies!)
        
        self.orderPlayerAndEnimies()
    }
    
    //MARK: - Touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        
        let location = touch.locationInNode(combatScene!)
        
        let nodePosition = combatScene!.nodeAtPoint(location)

        
        for var i = 0; i < players.count; ++i {
            players[i].touchesBegan(touches, withEvent: event)
            
            if nodePosition.name == players[i].name {
                //Set skills in SKSkillPlayers
                self.setSkillFromPlayer(players[i])
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for var i = 0; i < players.count; ++i {
            players[i].touchesMoved(touches, withEvent: event)
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for var i = 0; i < players.count; ++i {
            players[i].touchesEnded(touches, withEvent: event)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        for var i = 0; i < players.count; ++i {
            players[i].touchesCancelled(touches, withEvent: event)
        }
    }
    
    //MARK: - Update Method
    override func update(currentTime: NSTimeInterval) {
        
        for var i = 0; i < players.count; ++i {
            players[i].update(currentTime)
        }
    }
    
    //MARK: - Set Positions Players and Enimies
    private func setPlayersPositions(players: [Player]) {
        
        let skPositionPlayers = self.combatScene.childNodeWithName("SKPositionPlayers")!
        
        var currentPositions = CGPointZero
        
        for var i = 0; i < players.count; ++i {
            
            players[i].removeFromParent()
            players[i].setPlayerForCombat()
            players[i].alpha = 1.0
            players[i].position = CGPointMake(currentPositions.x, currentPositions.y)
            skPositionPlayers.addChild(players[i])
            currentPositions = CGPointMake(players[i].position.x - players[i].frame.width, players[i].frame.height - players[i].position.y)
        }
    }
    
    private func setEnimiesPositions(enimies: [NSObject]) {
        
        for var i = 0; i < enimies.count; ++i {
            
        }
    }
    
    //MARK: - Ordenation player and enimy for speed
    private func orderPlayerAndEnimies() {
        
    }
    
    private func setSkillFromPlayer(player: Player) {
        
        let skills = player.race.skills
        //let currentPosition: CGPoint = CGPointZero
        
        for var i = 0; i < skills.count; ++i {
            
        }
    }
}
