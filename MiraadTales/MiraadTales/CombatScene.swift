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
    var enimies: [Enemy]!
    var currentPlayer: Player!
    var currentEnemy: Enemy!
    var indicator: SKSpriteNode!
    
    public var typeCombat: String = ""
    
    override func didMoveToView(view: SKView) {
        
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        var bgCombat: SKSpriteNode
        
        if typeCombat == "Bellatrix" {
            bgCombat = SKSpriteNode(imageNamed: "")
        }else {
            bgCombat = SKSpriteNode(imageNamed: "sceneNormalCombat")
        }
        
        skCombatBg.addChild(bgCombat)
        
        indicator = SKSpriteNode(imageNamed: "reddot")
        indicator.name = "indicator"
        
        //setStatusPlayers(players)
        //setSkillFromPlayer(currentPlayer)
    }
    
    //MARK: - Touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        (self.view! as! NavigationController).GoBack()
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
        
    }
    
    //MARK: Set Enemy Position
    private func setEnimiesPositions(enimies: [NSObject]) {
        
        for var i = 0; i < enimies.count; ++i {
            
        }
    }
    
    //MARK: - Ordenation player and enimy for speed
    private func orderPlayerAndEnimies() {
        
    }
    
    //MARK: Set Status Players
    private func setStatusPlayers(players: [Player]) {
        
        let footer = self.childNodeWithName("skFooter")!
        let labelSkill = footer.childNodeWithName("SKLabelSkill")!
        
        var position = CGPointMake(0, labelSkill.position.y + (labelSkill.frame.height / 2))
        
        for var i = 0; i < players.count; ++i {
            
            var bgBarStatus = SKSpriteNode(imageNamed: "bgbar")
            bgBarStatus.position = CGPointMake(position.x - (bgBarStatus.frame.size.width / 2) - 20, position.y)
            
            let mpBarStatus = SKSpriteNode(imageNamed: "mpbar")
            mpBarStatus.name = "mpBar-\(players[i].race.name)"
            mpBarStatus.zPosition = 2
            
            let labelMp = SKLabelNode(text: "\(players[i].race.status.currentMP)/\(players[i].race.status.MP)")
            labelMp.fontColor = UIColor.whiteColor()
            labelMp.fontName = "Prospero-Bold-NBP"
            labelMp.zPosition = 4
            labelMp.position = CGPointMake(0, -10)
            labelMp.name = "hpLabel-\(players[i].race.name)"
            
            bgBarStatus.addChild(mpBarStatus)
            bgBarStatus.addChild(labelMp)
            footer.addChild(bgBarStatus)
            
            position = CGPointMake(bgBarStatus.position.x - (bgBarStatus.frame.size.width) - 20, position.y)
            
            bgBarStatus = SKSpriteNode(imageNamed: "bgbar")
            bgBarStatus.position = position
            
            let hpBarStatus = SKSpriteNode(imageNamed: "hpbar")
            hpBarStatus.name = "hpBar-\(players[i].race.name)"
            hpBarStatus.zPosition = 2
            
            let labelHp = SKLabelNode(text: "\(players[i].race.status.currentHP)/\(players[i].race.status.HP)")
            labelHp.fontColor = UIColor.whiteColor()
            labelHp.fontName = "Prospero-Bold-NBP"
            labelHp.zPosition = 4
            labelHp.position = CGPointMake(0, -10)
            labelHp.name = "hpLabel-\(players[i].race.name)"
            
            bgBarStatus.addChild(hpBarStatus)
            bgBarStatus.addChild(labelHp)
            footer.addChild(bgBarStatus)
            
            position = CGPointMake(bgBarStatus.position.x - (bgBarStatus.frame.size.width) + 20, position.y - 5)
            
            let labelName = SKLabelNode(text: "\(players[i].race.name)")
            labelName.fontColor = UIColor.whiteColor()
            labelName.fontName = "Prospero-Bold-NBP"
            labelName.zPosition = 2
            labelName.name = "labelName-\(players[i].race.name)"
            labelName.position = position
            footer.addChild(labelName)
            
            position = CGPointMake(position.x - (labelName.frame.size.width / 2) - 20, bgBarStatus.position.y + 5)
            
            if players[i].race.name == currentPlayer.race.name {
                indicator.position = position
                indicator.zPosition = 2
                indicator.xScale = 0.5
                indicator.yScale = 0.5
                footer.addChild(indicator)
            }
            
            position = CGPointMake(0, -((footer.frame.height / 2) - (footer.frame.height / 4)))
        }
    }
    
    //MARK: Set Skill Player
    private func setSkillFromPlayer(player: Player) {
        
        let skills = player.race.skills
        
        let footer = self.childNodeWithName("skFooter")!
        let labelSkill = footer.childNodeWithName("SKLabelSkill")!
        
        for var i = 0; i < 3; ++i {
            
            if i == 0 {
                skills[i].position = CGPointMake(labelSkill.position.x + (labelSkill.frame.size.width + (skills[i].frame.size.width / 2)), 0)
            }else {
                skills[i].position = CGPointMake(skills[i].position.x + skills[i].frame.size.width + 20, 0)
            }
            skills[i].zPosition = 10
            footer.addChild(skills[i])
        }
    }
}
