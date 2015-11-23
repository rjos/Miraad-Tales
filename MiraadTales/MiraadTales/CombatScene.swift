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
    //var indicator: SKSpriteNode!
    var orderPerson: [AnyObject]!
    
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
        
        setStatusPlayers(players)
        //setSkillFromPlayer(currentPlayer)
        setPlayersPositions(players)
        setIndicatorPlayer(players[1])
    }
    
    //MARK: - Touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //(self.view! as! NavigationController).GoBack()
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

        /*
        var enemiesLive = self.enimies.filter { (e) -> Bool in
            return !e.race.isDie
        }
        
        var playersLive = self.players.filter { (p) -> Bool in
            return !p.race.isDie
        }
        
        if !enemiesLive.isEmpty && !playersLive.isEmpty {
            self.orderPlayerAndEnimies(playersLive, enemies: enemiesLive)
        }else if enemiesLive.isEmpty {
            //Win
        }else {
            //Lose
        }*/
    }
    
    //MARK: Set Player Position
    private func setPlayersPositions(players: [Player]) {
        
        var positionCur = CGPointMake(-250,-150)
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        
        for var i = 0; i < players.count; ++i {
            
            players[i].removeFromParent()
            players[i].setPlayerForCombat()
            players[i].position = positionCur
            
            if i == 0 {
                positionCur = CGPointMake(positionCur.x + 120, positionCur.y + 80)
            }else {
                positionCur = CGPointMake(positionCur.x - 100, positionCur.y + 50)
            }
            
            skCombatBg.addChild(players[i])
        }
    }
    
    //MARK: Set Enemy Position
    private func setEnimiesPositions(enimies: [Enemy]) {
        
        for var i = 0; i < enimies.count; ++i {
            
        }
    }
    
    //MARK: - Ordenation player and enimy for speed
    private func orderPlayerAndEnimies(players: [Player], enemies: [Enemy]) {
        
        var orderPlayers = players.sort { (a, b) -> Bool in
            return a.race.status.Speed > b.race.status.Speed
        }
        
        var orderEnemies = enemies.sort { (a, b) -> Bool in
            return a.race.status.Speed > b.race.status.Speed
        }
        
        var orderPlayerPerson: [AnyObject] = []
        
        for p in orderPlayers {
            orderPlayerPerson.append(p)
        }
        
        for e in orderEnemies {
            orderPlayerPerson.append(e)
        }
        
        self.orderPerson = orderPlayerPerson.sort { (a, b) -> Bool in
            if a is Player && b is Enemy {
                return (a as! Player).race.status.Speed > (b as! Enemy).race.status.Speed
            }else if a is Enemy && b is Player {
                return (a as! Enemy).race.status.Speed > (b as! Player).race.status.Speed
            }else if a is Player && b is Player {
                return (a as! Player).race.status.Speed > (b as! Player).race.status.Speed
            }else {
                return (a as! Enemy).race.status.Speed > (b as! Enemy).race.status.Speed
            }
        }
        
        var p = self.orderPerson.first!
        
        if p is Player && (p as! Player) != self.currentPlayer {
            self.currentPlayer = (p as! Player)
            setSkillFromPlayer(self.currentPlayer)
        }
    }
    
    //MARK: Set Indicator Player
    private func setIndicatorPlayer(player: Player) {
        
        let footer = self.childNodeWithName("skFooter")!
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        let labelName = footer.childNodeWithName("labelName-\(player.race.name)")!
        
        var indicatorFooter = footer.childNodeWithName("indicator-footer")
        
        if indicatorFooter == nil {
            indicatorFooter = SKSpriteNode(imageNamed: "reddot")
            indicatorFooter!.name = "indicator-footer"
            indicatorFooter!.zPosition = 2
            indicatorFooter!.xScale = 0.5
            indicatorFooter!.yScale = 0.5
            footer.addChild(indicatorFooter!)
        }
        
        indicatorFooter!.position = CGPointMake(labelName.position.x - (labelName.frame.size.width / 2) - 15, labelName.position.y + 10)
        
        var indicatorBg = skCombatBg.childNodeWithName("indicator-bg")
        if indicatorBg == nil {
            
            indicatorBg = SKSpriteNode(imageNamed: "reddot")
            indicatorBg!.name = "indicator-bg"
            indicatorBg!.position = CGPointMake(player.position.x, player.position.y + (player.frame.height / 2) + 10)
            indicatorBg!.zPosition = 2
            indicatorBg!.xScale = 0.8
            indicatorBg!.yScale = 0.8
            skCombatBg.addChild(indicatorBg!)
        }
        
        indicatorBg!.position = CGPointMake(player.position.x, player.position.y + (player.frame.height / 2) + 20)
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
