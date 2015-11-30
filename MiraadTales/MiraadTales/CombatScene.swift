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
    
    var orderPerson: [SKSpriteNode]!
    var endTurn = true
    
    var showHpEnemy = false
    var beginTime: NSTimeInterval = 0.0
    
    public var typeCombat: String = ""
    
    var currentIndexPlayer = 0
    var startTurn = false
    
    var executeTurn: Bool = false
    
    var otherPlayer: [Player] = []
    var prepareAtk: [Player: (Enemy, Skill)] = [:]
    var skillCurr: Skill!
    var enemyCurr: Enemy!
    
    var timeExecute: NSTimeInterval = 0
    var countAtks = 0
    
    var skCombatBg: SKNode!
    var completedAnimation = true
    
    override func didMoveToView(view: SKView) {
        
        skCombatBg = self.childNodeWithName("SKCombatBg")!
        var bgCombat: SKSpriteNode
        
        if typeCombat == "Bellatrix" {
            bgCombat = SKSpriteNode(imageNamed: "")
        }else {
            bgCombat = SKSpriteNode(imageNamed: "sceneNormalCombat")
        }
        
        skCombatBg.addChild(bgCombat)
        
        otherPlayer = players
        
        setStatusPlayers(players)
        setPlayersPositions(players)
        setEnimiesPositions(enimies)
    }
    
    //MARK: - Touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if (node is Enemy) && self.skillCurr == nil {
                self.setLifeEnemy((node as! Enemy))
                showHpEnemy = true
            }else if (node is Skill) && (self.skillCurr == nil) && !executeTurn {
                skillCurr = (node as! Skill)
                
                let rotR = SKAction.rotateByAngle(0.05, duration: 0.2)
                let rotL = SKAction.rotateByAngle(-0.05, duration: 0.2)
                let cycle = SKAction.sequence([rotR, rotL, rotL, rotR])
                let wiggle = SKAction.repeatActionForever(cycle)
                
                skillCurr.runAction(wiggle, withKey: "animatedSkill")
                
            }else if (node is Enemy) && (self.skillCurr != nil) && !executeTurn {
                enemyCurr = (node as! Enemy)
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

        //Start turn
        if startTurn {
            startTurn = false
            currentIndexPlayer = 0
        }
        
        //Damage turn
        if self.skillCurr != nil && self.enemyCurr != nil { /* prepare atk */
            
            prepareAtk[self.currentPlayer] = (enemyCurr, skillCurr)
            
            self.skillCurr.removeActionForKey("animatedSkill")
            
            let restoreAngle = SKAction.rotateToAngle(0, duration: 0.1)
            self.skillCurr.runAction(restoreAngle)
            
            self.skillCurr = nil
            self.enemyCurr = nil
            
            ++currentIndexPlayer
            
            if currentIndexPlayer == self.players.count {
                executeTurn = true
                currentIndexPlayer = 0
                timeExecute = currentTime
            }else{
                
                otherPlayer = otherPlayer.filter({ (p) -> Bool in
                    return p.name != self.currentPlayer.name
                })
             
                let p = otherPlayer.first!
                otherPlayer.removeFirst()
                self.currentPlayer = p
                setIndicatorPlayer(self.currentPlayer)
                setSkillFromPlayer(self.currentPlayer)
            }
        }else if executeTurn && (currentTime - timeExecute) >= 0.5 && completedAnimation { /* execute atk */
            completedAnimation = false
            timeExecute = currentTime
            
            let actualPerson = self.orderPerson!.first!
            var target: SKSpriteNode!
            var skill: SKSpriteNode!
            
            if actualPerson is Player {
                let item = prepareAtk.first!
                target = item.1.0
                skill = item.1.1
                
                prepareAtk.removeValueForKey((actualPerson as! Player))
            }else {
                //Generate random a atk from enemy
            }
            
            var totalAtkActualPerson: Int = 0
            var totalDefActualPerson: Int = 0
            
            //Calculate Damage
            if actualPerson is Player {
                totalAtkActualPerson = (actualPerson as! Player).race.calculateAtk() + (skill as! Skill).baseSkill.calculateAtk()
                
                totalDefActualPerson = (target as! Enemy).race.calculateDef()
            }else {
                totalAtkActualPerson = (actualPerson as! Enemy).race.calculateAtk() + (skill as! Skill).baseSkill.calculateAtk()
                
                totalDefActualPerson = (target as! Player).race.calculateDef()
            }
            
            //Execute Skill animation
            var nameSkill = (skill as! Skill).baseSkill.fantasyName
            nameSkill = nameSkill.stringByReplacingOccurrencesOfString(" ", withString: "")
            let animationSKill = SKTextureAtlas(named: "\(nameSkill)")
            var textureAnimationSkill = [SKTexture]()
            
            for var i = 0; i < animationSKill.textureNames.count; ++i {
                let texture = animationSKill.textureNamed("\(nameSkill)-\((i + 1))")
                textureAnimationSkill.append(texture)
            }
            
            var spriteSKillToAnimated = SKSpriteNode(texture: textureAnimationSkill[0])
            spriteSKillToAnimated.position = CGPointMake(target.position.x, target.position.y + (target.frame.height / 2) + 5)
            spriteSKillToAnimated.zPosition = target.zPosition + 1
            spriteSKillToAnimated.xScale = 1.5
            spriteSKillToAnimated.yScale = 1.5
            
            skCombatBg.addChild(spriteSKillToAnimated)
            
            let animation = SKAction.animateWithTextures(textureAnimationSkill, timePerFrame: 0.2)
            spriteSKillToAnimated.runAction(animation, completion: { () -> Void in
                
                spriteSKillToAnimated.removeFromParent()
                
                //Decrease Hp target
                var race: BaseRace
                
                if target is Player {
                    race = (target as! Player).race
                }else {
                    race = (target as! Enemy).race
                }
                
                race.status.currentHP = max(race.status.currentHP - (totalAtkActualPerson - totalDefActualPerson), 0)
                
                if target is Enemy {
                    self.setLifeEnemy((target as! Enemy))
                }
                
                if race.status.currentHP == 0 {
                    target.removeFromParent()
                    
                    if target is Player {
                        (target as! Player).race.isDie = true
                    }else {
                        (target as! Enemy).race.isDie = true
                    }
                }
                
                let isFinish = self.checkIsEndBattle()
                
                if !isFinish {
                    self.executeTurn = false
                    self.endTurn = true
                }else {
                    self.completedAnimation = true
                }
            })
            
            //Exit turn
            ++countAtks
            if countAtks == self.orderPerson.count {
                executeTurn = false
                endTurn = true
            }
        }
        
        //End turn
        if endTurn {
            
            endTurn = false
            startTurn = true
            
            var enemiesLive = self.enimies.filter { (e) -> Bool in
                return !e.race.isDie
            }
            
            var playersLive = self.players.filter { (p) -> Bool in
                return !p.race.isDie
            }
            
            if !enemiesLive.isEmpty && !playersLive.isEmpty {
                self.orderPlayerAndEnimies(playersLive, enemies: enemiesLive)
            }else {
                
                if enemiesLive.isEmpty {
                    //win
                    print("você venceu")
                }else {
                    print("vecê perdeu")
                }
                
                //Return mvp ou other scene
                (self.view! as! NavigationController).GoBack()
            }
        }
        
        //Show Hp enemy
        if showHpEnemy {
            beginTime = currentTime
            showHpEnemy = false
        }
        
        if (currentTime - beginTime) >= 1.5 {
            beginTime = currentTime
            
            let skCombatBg = self.childNodeWithName("SKCombatBg")!
            
            let hpEnemy = skCombatBg.childNodeWithName("hpEnemy")
            
            if hpEnemy != nil {
                let action = SKAction.fadeOutWithDuration(0.5)
                hpEnemy!.runAction(action, completion: { () -> Void in
                    hpEnemy!.removeFromParent()
                })
            }
        }
    }
    
    //MARK: Set Player Position
    private func setPlayersPositions(players: [Player]) {
        
//        var positionCur = CGPointMake(-250,-150)
        var positionCur = CGPointMake(-130, -70)
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        
        for var i = 0; i < players.count; ++i {
            
            players[i].removeFromParent()
            players[i].setPlayerForCombat()
            players[i].position = positionCur
            
            if i == 0 {
                positionCur = CGPointMake(positionCur.x - 120, positionCur.y - 80)
            }else {
                positionCur = CGPointMake(positionCur.x + 20, positionCur.y + 130)
            }
            
            skCombatBg.addChild(players[i])
        }
    }
    
    //MARK: Set Enemy Position
    private func setEnimiesPositions(enimies: [Enemy]) {
        
//        var positionCur = CGPointMake(250,-150)
        var positionCur = CGPointMake(130, -70)
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        
        for var i = 0; i < enimies.count; ++i {
            
            enimies[i].removeFromParent()
            enimies[i].position = positionCur
            enimies[i].zPosition = 5
            enimies[i].xScale = 1.5
            enimies[i].yScale = 1.5
            
            if i == 0 {
                positionCur = CGPointMake(positionCur.x + 120, positionCur.y - 80)
            }else {
                positionCur = CGPointMake(positionCur.x - 220, positionCur.y + 130)
            }
            
            skCombatBg.addChild(enimies[i])
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
        
        var orderPlayerPerson: [SKSpriteNode] = []
        
        for p in orderPlayers {
            orderPlayerPerson.append(p)
        }
        
        for e in orderEnemies {
            orderPlayerPerson.append(e)
        }
        
        self.orderPerson = orderPlayerPerson.sort { (a, b) -> Bool in
            if a is Player && b is Enemy {
                return (a as! Player).race.status.Speed >= (b as! Enemy).race.status.Speed
            }else if a is Enemy && b is Player {
                return (a as! Enemy).race.status.Speed > (b as! Player).race.status.Speed
            }else if a is Player && b is Player {
                return (a as! Player).race.status.Speed >= (b as! Player).race.status.Speed
            }else {
                return (a as! Enemy).race.status.Speed >= (b as! Enemy).race.status.Speed
            }
        }
        
        var p = self.orderPerson.first!
        
        if p is Player && (p as! Player) != self.currentPlayer {
            self.currentPlayer = (p as! Player)
            setIndicatorPlayer(self.currentPlayer)
            setSkillFromPlayer(self.currentPlayer)
        }
        
        setPlayerEnemiesFromSpeed(self.orderPerson)
    }
    
    //MARK: Set player and enimies from speed
    private func setPlayerEnemiesFromSpeed(orderPerson: [SKSpriteNode]) {
        
        var posCurr = CGPointMake(-450, 334)
        var currDecrease: CGFloat
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        
        
        for var i = 0; i < orderPerson.count; ++i {
            
            var p = orderPerson[i]
            var nameFromPerson: String = ""
            var turnPerson: SKSpriteNode!
            
            if p is Player {
                nameFromPerson = "turnfriend"
            }else {
                nameFromPerson = "turnenemy"
            }
            
            if i == 0 {
                turnPerson = SKSpriteNode(imageNamed: "\(nameFromPerson)-\(i)")
                currDecrease = 0
            }else {
                turnPerson = SKSpriteNode(imageNamed: "\(nameFromPerson)-1")
                currDecrease = 16
            }
            
            posCurr = CGPointMake(-450 - currDecrease, posCurr.y - (turnPerson.frame.height / 2))
            
            turnPerson.zPosition = 5
            turnPerson.position = posCurr
            
            var person = SKSpriteNode(imageNamed: "\(p.name!)-2")
            person.zPosition = 1
            
            turnPerson.addChild(person)
            skCombatBg.addChild(turnPerson)
            
            posCurr = CGPointMake(-450, posCurr.y - ((turnPerson.frame.height / 2) + 5))
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
            bgBarStatus.zPosition = 2
            
            let mpBarStatus = SKSpriteNode(color: UIColor(red: 0.1, green: 0.71, blue: 0.83, alpha: 1), size: CGSizeMake(bgBarStatus.frame.size.width - 5, bgBarStatus.frame.size.height - 5))
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
            bgBarStatus.zPosition = 2
            
            let hpBarStatus = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(bgBarStatus.frame.size.width - 5, bgBarStatus.frame.size.height - 5))
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
        
        for var i = 0; i < skills.count; ++i {
            
            if i == 0 {
                skills[i].position = CGPointMake(labelSkill.position.x + (labelSkill.frame.size.width + (skills[i].frame.size.width / 2)), 0)
            }else {
                skills[i].position = CGPointMake(skills[i].position.x + skills[i].frame.size.width + 20, 0)
            }
            skills[i].zPosition = 10
            footer.addChild(skills[i])
        }
    }
    
    //MARK: Set Life to from enemy
    private func setLifeEnemy(enemy: Enemy) {
        
        let skCombatBg = self.childNodeWithName("SKCombatBg")!
        
        let max = enemy.race.status.HP
        let curr = enemy.race.status.currentHP
        
        let currWidth = CGFloat((curr * 100) / max)
        
        let textureBg = SKTexture(imageNamed: "bgbar")
        let spriteBg = SKSpriteNode(texture: textureBg, color: UIColor.clearColor(), size: CGSizeMake(103, 20))
        spriteBg.name = "hpEnemy"
        spriteBg.zPosition = 5
        spriteBg.position = CGPointMake(enemy.position.x, (enemy.position.y + (enemy.frame.height / 2) + 10))
        
        let currHP = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(currWidth, 17))
        currHP.zPosition = 1
        
        let labelHP = SKLabelNode(text: "\(curr)/\(max)")
        labelHP.horizontalAlignmentMode = .Center
        labelHP.verticalAlignmentMode = .Center
        labelHP.fontName = "Prospero-Bold-NBP"
        labelHP.fontColor = UIColor.whiteColor()
        labelHP.zPosition = 2
        labelHP.fontSize = 18
        
        spriteBg.addChild(currHP)
        spriteBg.addChild(labelHP)
        skCombatBg.addChild(spriteBg)
    }
    
    private func checkIsEndBattle() -> Bool {
        
        var isPlayer = false
        var isEnemy = false
        
        for var i = 0; i < self.orderPerson!.count; ++i {
            
            if self.orderPerson![i] is Player && !(self.orderPerson![i] as! Player).race.isDie {
                isPlayer = true
                continue
            }else if !(self.orderPerson![i] as! Enemy).race.isDie {
                isEnemy = true
                continue
            }
        }
        
        return (isPlayer && isEnemy)
    }
}
