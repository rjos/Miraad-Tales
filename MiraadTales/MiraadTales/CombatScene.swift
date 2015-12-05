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
    
    var currentIndexPlayer = 0
    var startTurn = false
    
    var executeTurn: Bool = false
    
    var otherPlayer: [Player] = []
    var prepareAtk: [String: (SKSpriteNode, Skill)] = [:]
    
    var skillCurr: Skill!
    var tempSkill: Skill!
    
    var targetCurr: SKSpriteNode!
    var tempTarget: SKSpriteNode!
    
    var liveIsPerson: [SKSpriteNode] = []
    
    var timeExecute: NSTimeInterval = 0
    var countAtks = 0
    
    var skCombatBg: SKNode!
    var completedAnimation = true
    
    var targetSkill: TargetSkill!
    
    var velocityAtk = 0.5
    var spriteSKillToAnimated: SKSpriteNode!
    
    var orderAtksPerson: [SKSpriteNode] = []
    
    var battleEnd: BattleEnd!
    var openBattleEnd: NSTimeInterval = 0.0
    var endBattle: Bool = false
    
    internal var win: Bool = false
    internal var typeCombat: String = ""
    
    override func didMoveToView(view: SKView) {
        
        skCombatBg = self.childNodeWithName("SKCombatBg")!
        var bgCombat: SKSpriteNode
        
        self.playAudio("Surreptitious")
        self.changeVolume(100)
        
        if typeCombat == "Bellatrix" {
            bgCombat = SKSpriteNode(imageNamed: "combatscenarioBellatrix")
            
            let atlasCauldron = SKTextureAtlas(named: "cauldronCombat")
            let countTexture = atlasCauldron.textureNames.count
            var textures: [SKTexture] = []
            
            for var i = 0; i < countTexture; ++i {
                let texture = atlasCauldron.textureNamed("cauldronCombat-\(i+1)")
                textures.append(texture)
            }
            
            let action = SKAction.animateWithTextures(textures, timePerFrame: 0.2, resize: false, restore: false)
            
            let cauldron = SKSpriteNode(texture: textures[0])
            cauldron.zPosition = 5
            cauldron.position = CGPointMake(300,(bgCombat.frame.height / 2) - (cauldron.frame.height + 10))
            cauldron.runAction(SKAction.repeatActionForever(action))
            
            bgCombat.addChild(cauldron)
            
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
        
        if battleEnd != nil {
            battleEnd.touchesBegan(touches, withEvent: event)
        }else {
            for touch in touches {
                
                let location = touch.locationInNode(self)
                
                let node = self.nodeAtPoint(location)
                
                if (node is Enemy) && self.skillCurr == nil {
                    self.setLifeEnemy((node as! Enemy))
                    showHpEnemy = true
                }else if (node is Skill) && !executeTurn {
                    tempSkill = (node as! Skill)
                    
                    if tempSkill != self.skillCurr && self.currentPlayer.race.status.currentMP >= tempSkill.baseSkill.consumeMana {
                        
                        self.skillCurr = tempSkill
                        
                        if self.skillCurr.baseSkill.effect != nil {
                            self.targetSkill = self.skillCurr.baseSkill.effect!.target
                        }
                        
                        applyAnimationSkill(self.skillCurr)
                    }else {
                        tempSkill = nil
                    }
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if tempSkill != nil {
            for touch in touches {
                
                let location = touch.locationInNode(self)
                
                let node = self.nodeAtPoint(location)
                
                if (node is Skill) && (node as! Skill) != self.skillCurr {
                    
                    disapplyAnimationSkill(self.skillCurr)
                    
                    tempSkill = (node as! Skill)
                    self.skillCurr = tempSkill
                    
                    applyAnimationSkill(self.skillCurr)
                }else if targetSkill == nil || targetSkill == TargetSkill.SingleEnemy {
                    
                    if (node is Enemy) {
                        
                        if tempTarget != nil && (node as! Enemy) != tempTarget {
                            disapplyAnimationTarget(tempTarget)
                        }
                        
                        tempTarget = (node as! Enemy)
                        applyAnimationTarget(tempTarget)
                        
                    }else {
                        
                        if tempTarget != nil {
                            disapplyAnimationTarget(tempTarget)
                            tempTarget = nil
                        }
                    }
                }else if targetSkill == TargetSkill.SinglePlayer {
                    
                    if (node is Player) {
                        
                        if tempTarget != nil && (node as! Player) != tempTarget {
                            disapplyAnimationTarget(tempTarget)
                        }
                        
                        tempTarget = (node as! Player)
                        applyAnimationTarget(tempTarget)
                    }else {
                        
                        if tempTarget != nil {
                            disapplyAnimationTarget(tempTarget)
                            tempTarget = nil
                        }
                    }
                }
            }
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.skillCurr != nil {
            for touch in touches {
                let location = touch.locationInNode(self)
                
                let node = self.nodeAtPoint(location)
                
                if (node is Enemy) && tempTarget != nil && (node as! Enemy) == tempTarget {
                    self.targetCurr = tempTarget
                }else if (node is Player) && tempTarget != nil && (node as! Player) == tempTarget {
                    self.targetCurr = tempTarget
                }
                
                if tempTarget != nil {
                    disapplyAnimationTarget(tempTarget)
                }else if self.skillCurr != nil {
                    disapplyAnimationSkill(self.skillCurr)
                    
                    self.tempSkill = nil
                    self.skillCurr = nil
                }
            }
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
            otherPlayer = self.players.filter({ (p) -> Bool in
                return !p.race.isDie
            })
            velocityAtk = 0.5
        }
        
        //Prepare atks
        if self.skillCurr != nil && self.targetCurr != nil && !executeTurn { /* prepare atk */
            
            prepareAtk[self.currentPlayer!.race.name] = (targetCurr, skillCurr)
            
            disapplyAnimationSkill(self.skillCurr)
            
            disapplyAnimationTarget(self.targetCurr)
            
            self.skillCurr = nil
            self.targetCurr = nil
            
            self.tempSkill = nil
            self.tempTarget = nil
            
            ++currentIndexPlayer
            
            if currentIndexPlayer == self.players.count {
                executeTurn = true
                currentIndexPlayer = 0
                countAtks = 0
                timeExecute = currentTime
                completedAnimation = true
                
                self.removeSkillFromFooter()
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
        }else if executeTurn && (currentTime - timeExecute) >= velocityAtk && completedAnimation { /* execute atk */
            completedAnimation = false
            
            self.liveIsPerson = self.orderPerson!.filter({ (s) -> Bool in
                if s is Player {
                    return !(s as! Player).race.isDie
                }else {
                    return !(s as! Enemy).race.isDie
                }
            })
            
            let actualPerson = self.liveIsPerson[countAtks]
            var target: SKSpriteNode!
            var skill: Skill!
            
            if actualPerson is Player {
                
                let (t, s) = prepareAtk[(actualPerson as! Player).race.name]!
                
                target = t
                skill = s
                                
                print(skill.baseSkill.name)
                
                prepareAtk.removeValueForKey((actualPerson as! Player).race.name)
            }else {
                //Generate random a atk from enemy
                let playersInLive = self.players.filter({ (p) -> Bool in
                    return !p.race.isDie
                })
                
                target = generateRandomTargetAtk(playersInLive)
                skill = generateRandomSkillAtk((actualPerson as! Enemy))
            }
            
            if (target is Player) && (target as! Player).race.isDie {
                //atk other player
                let tempPlayers = self.players.filter({ (p) -> Bool in
                    return !p.race.isDie
                })
                
                target = tempPlayers.first!
            }else if (target is Enemy) && (target as! Enemy).race.isDie {
                //atk other enemy
                let tempEnemies = self.enimies.filter({ (e) -> Bool in
                    return !e.race.isDie
                })
                
                target = tempEnemies.first!
            }
            
            //Execute Skill animation
            var nameSkill = (skill as! Skill).baseSkill.fantasyName
            nameSkill = nameSkill.stringByReplacingOccurrencesOfString(" ", withString: "")
            
            if actualPerson is Player && skill.baseSkill.fantasyName == "Basic hit" {
                nameSkill = "\(nameSkill)\((actualPerson as! Player).race.name)"
            }
            
            nameSkill = nameSkill.stringByReplacingOccurrencesOfString(".", withString: "")
            
            let animationSKill = SKTextureAtlas(named: "\(nameSkill)")
            var textureAnimationSkill = [SKTexture]()
            
            for var i = 0; i < (animationSKill.textureNames.count / 2); ++i {
                let texture = animationSKill.textureNamed("\(nameSkill)-\((i + 1))")
                textureAnimationSkill.append(texture)
            }
            
            spriteSKillToAnimated = SKSpriteNode(texture: textureAnimationSkill[0])
            
            if nameSkill == "Heal" {
                spriteSKillToAnimated.position = CGPointMake(target.position.x, (target.position.y + 30) - (target.frame.height / 2))
            }else {
                spriteSKillToAnimated.position = CGPointMake(target.position.x, target.position.y + (target.frame.height / 2) + 5)
            }
            
            spriteSKillToAnimated.zPosition = target.zPosition + 1
            spriteSKillToAnimated.xScale = 1.5
            spriteSKillToAnimated.yScale = 1.5
            
            skCombatBg.addChild(spriteSKillToAnimated)
            
            let animation = SKAction.animateWithTextures(textureAnimationSkill, timePerFrame: 0.2)
            spriteSKillToAnimated.runAction(animation, completion: { () -> Void in
                
                var targetSkill: TargetSkill! = nil
                var affectSkill: AffectSkill!
                var percente: Int = 0
                
                if skill.baseSkill.effect != nil {
                    targetSkill = skill.baseSkill.effect!.target
                    affectSkill = skill.baseSkill.effect!.affect
                    percente = skill.baseSkill.effect!.percenteEffects
                }else {
                    affectSkill = nil
                }
                
                var totalAtkActualPerson: Int = 0
                var totalDefActualPerson: Int = 0
                
                if targetSkill == nil || targetSkill == TargetSkill.SingleEnemy {
                    
                    //Calculate Damage
                    if actualPerson is Player {
                        totalAtkActualPerson = (actualPerson as! Player).race.calculateAtk() + (skill as! Skill).baseSkill.calculateAtk()
                        
                        totalDefActualPerson = (target as! Enemy).race.calculateDef()
                    }else {
                        totalAtkActualPerson = (actualPerson as! Enemy).race.calculateAtk() + (skill as! Skill).baseSkill.calculateAtk()
                        
                        totalDefActualPerson = (target as! Player).race.calculateDef()
                    }
                    
                    var reduce: Int = 0
                    
                    if totalAtkActualPerson > totalDefActualPerson {
                        reduce = (totalAtkActualPerson - totalDefActualPerson)
                    }else {
                        reduce = 1
                    }
                    
                    //Decrease Hp target
                    var race: BaseRace
                    
                    if target is Player {
                        race = (target as! Player).race
                    }else {
                        race = (target as! Enemy).race
                    }
                    
                    let curr = race.status.currentHP
                    race.status.currentHP = max(race.status.currentHP - reduce, 0)
                    
                    //Update bar Hp player
                    if target is Player {
                        
                        self.decreaseHP(target as! Player)
                    }else { /* Update bar hp enemy */
                        
                        self.setLifeEnemy(target as! Enemy)
                    }
                    
                    //Decrease MP
                    if actualPerson is Player {
                        
                        (actualPerson as! Player).race.status.currentMP = max((actualPerson as! Player).race.status.currentMP - skill.baseSkill.consumeMana, 0)
                        self.decreaseMP(actualPerson as! Player)
                    }
                    
                    // Check if target is die
                    if race.status.currentHP == 0 {
                        target.removeFromParent()
                        race.isDie = true
                    }
                    
                }else if targetSkill == TargetSkill.SinglePlayer {
                    //Buffer or debuffer
                }
                
                //                //Affects
                //                if affectSkill == AffectSkill.HP {
                //                    //increment HP
                //                }else if affectSkill == AffectSkill.MP {
                //                    //increment MP
                //                }else if affectSkill == AffectSkill.mAtk || affectSkill == AffectSkill.pAtk {
                //                    //incremet Atk
                //                }else if affectSkill == AffectSkill.mDef || affectSkill == AffectSkill.pDef {
                //                    //increment Def
                //                }
                
                let isFinish = self.checkIsEndBattle()
                
                if !isFinish {
                    self.executeTurn = false
                    self.endTurn = true
                }else {
                    
                    if self.countAtks != self.liveIsPerson.count {
                        self.timeExecute = currentTime
                        self.velocityAtk = 2.0
                    }
                }
                
                self.completedAnimation = true
                self.spriteSKillToAnimated.removeFromParent()
                
                self.orderAtksPerson = self.orderAtksPerson.filter({ (p) -> Bool in
                    if p is Player {
                        return !(p as! Player).race.isDie
                    }else {
                        return !(p as! Enemy).race.isDie
                    }
                })
                
                self.nextPlayerEnemiesFromSpeed()
            })
            
            //Exit turn
            ++countAtks
            if countAtks == self.liveIsPerson.count {
                executeTurn = false
                endTurn = true
            }
        }
        
        //End turn
        if endTurn && completedAnimation {
            
            endTurn = false
            startTurn = true
            
            var enemiesLive = self.enimies.filter { (e) -> Bool in
                return !e.race.isDie
            }
            
            var playersLive = self.players.filter { (p) -> Bool in
                return !p.race.isDie
            }
            
            if !enemiesLive.isEmpty && !playersLive.isEmpty {
                executeTurn = false
                self.orderPlayerAndEnimies(playersLive, enemies: enemiesLive)
            }else {
                
                if enemiesLive.isEmpty {
                    //win
                    print("você venceu")
                    win = true
                }else {
                    print("vecê perdeu")
                    win = false
                }
                
                openBattleEnd = currentTime
                endBattle = true
                
                //Return mvp ou other scene
                //(self.view! as! NavigationController).GoBack()
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
        
        if (currentTime - openBattleEnd) >= 1.0  && endBattle {
            
            if battleEnd == nil {
                
                var name: String = ""
                
                if win {
                    name = "You won!"
                }else {
                    name = "You lost!"
                }
                
                battleEnd = BattleEnd(players: self.players!, currentPlayer: self.currentPlayer!, size: self.size, name: name, typeHUD: TypeHUD.BattleEnd)
                
                battleEnd.zPosition = 20
                battleEnd.xScale = 0.01
                battleEnd.yScale = 0.01
                
                self.addChild(battleEnd)
                
                battleEnd.open()
            }else if battleEnd.typeBattleEnd == TypeBattleEnd.Continue {
                
                if self.typeCombat != "Bellatrix" {
                    let transition = SKTransition.fadeWithDuration(1)
                    
                    (self.view as! NavigationController).GoBack(transition)
                }else {
                    let gameover = GameOverScene(fileNamed: "GameOverScene")!
                    let transition = SKTransition.fadeWithDuration(3)
                    
                    (self.view as! NavigationController).Navigate(gameover, transition: transition)
                }
            }else if battleEnd.typeBattleEnd == TypeBattleEnd.TryAgain {
                (self.view as! NavigationController).GoBack()
            }else if battleEnd.typeBattleEnd == TypeBattleEnd.CanBack {
                let start = Start(fileNamed: "Start")!
                let transition = SKTransition.fadeWithDuration(1)
                (self.view as! NavigationController).Navigate(start, transition: transition)
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
            
            //enimies[i].removeFromParent()
            enimies[i].position = positionCur
            enimies[i].zPosition = 10
            enimies[i].xScale = enimies[i].xScale * 1.5
            enimies[i].yScale = enimies[i].yScale * 1.5
            
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
        }
        
        setIndicatorPlayer(self.currentPlayer)
        setSkillFromPlayer(self.currentPlayer)
        
        self.orderAtksPerson = self.orderPerson!
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
            turnPerson.name = "turnAtk-\(i)"
            turnPerson.position = posCurr
            
            var person = SKSpriteNode(imageNamed: "\(p.name!)-2")
            person.zPosition = 1
            
            turnPerson.addChild(person)
            skCombatBg.addChild(turnPerson)
            
            posCurr = CGPointMake(-450, posCurr.y - ((turnPerson.frame.height / 2) + 5))
        }
    }
    
    private func nextPlayerEnemiesFromSpeed() {
        
        let first = self.orderAtksPerson.removeFirst()
        
        if ((first is Player) && !(first as! Player).race.isDie) ||
            ((first is Enemy) && !(first as! Enemy).race.isDie) {
                self.orderAtksPerson.append(first)
        }
        
        let skCombat = self.childNodeWithName("SKCombatBg")!
        
        for child in skCombat.children {
            
            if (child is SKSpriteNode) && (child as! SKSpriteNode).name != nil && (child as! SKSpriteNode).name!.containsString("turnAtk") {
                child.removeFromParent()
            }
        }
        
        self.setPlayerEnemiesFromSpeed(self.orderAtksPerson)
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
            bgBarStatus.name = "bgBarStatusMp-\(players[i].race.name)"
            
            let mpBarStatus = SKSpriteNode(color: UIColor(red: 0.1, green: 0.71, blue: 0.83, alpha: 1), size: CGSizeMake(bgBarStatus.frame.size.width - 5, bgBarStatus.frame.size.height - 5))
            mpBarStatus.name = "mpBar-\(players[i].race.name)"
            mpBarStatus.zPosition = 2
            
            let labelMp = SKLabelNode(text: "\(players[i].race.status.currentMP)/\(players[i].race.status.MP)")
            labelMp.fontColor = UIColor.whiteColor()
            labelMp.fontName = "Prospero-Bold-NBP"
            labelMp.zPosition = 4
            labelMp.position = CGPointMake(0, -10)
            labelMp.name = "mpLabel-\(players[i].race.name)"
            
            bgBarStatus.addChild(mpBarStatus)
            bgBarStatus.addChild(labelMp)
            footer.addChild(bgBarStatus)
            
            position = CGPointMake(bgBarStatus.position.x - (bgBarStatus.frame.size.width) - 20, position.y)
            
            bgBarStatus = SKSpriteNode(imageNamed: "bgbar")
            bgBarStatus.position = position
            bgBarStatus.zPosition = 2
            bgBarStatus.name = "bgBarStatusHp-\(players[i].race.name)"
            
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
        
        self.removeSkillFromFooter()
        
        for var i = 0; i < skills.count; ++i {
            
            skills[i].name = "skill-\(i)"
            skills[i].xScale = 1.5
            skills[i].yScale = 1.5
            
            if i == 0 {
                skills[i].position = CGPointMake(labelSkill.position.x + (labelSkill.frame.size.width + (skills[i].frame.size.width / 2)), 0)
            }else {
                skills[i].position = CGPointMake(skills[i - 1].position.x + skills[i].frame.size.width + 20, 0)
            }
            skills[i].zPosition = 10
            footer.addChild(skills[i])
        }
        
        checkSkills()
    }
    
    private func removeSkillFromFooter() {
        
        let footer = self.childNodeWithName("skFooter")!
        
        //Remove skills from footer
        for var i = 0; i < 3; ++i {
            
            let currSkill = footer.childNodeWithName("skill-\(i)")
            
            if currSkill != nil {
                currSkill!.removeFromParent()
            }
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
        currHP.name = "currHP"
        currHP.position = CGPointMake(-((100 - currWidth) / 2), 0)
        
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
    
    //MARK: Check end Battle
    private func checkIsEndBattle() -> Bool {
        
        var isPlayer = false
        var isEnemy = false
        
        for var i = 0; i < self.orderPerson!.count; ++i {
            
            if (self.orderPerson![i] is Player) && !(self.orderPerson![i] as! Player).race.isDie {
                isPlayer = true
                continue
            }else if (self.orderPerson![i] is Enemy) && !(self.orderPerson![i] as! Enemy).race.isDie {
                isEnemy = true
                continue
            }
        }
        
        return (isPlayer && isEnemy)
    }
    
    //MARK: Generate random Skill and Player from enemy
    private func generateRandomSkillAtk(e: Enemy) -> Skill {
        
        let number = arc4random()
        
        var skill: Skill
        
        if e.race.skills.count == 1 {
            return e.race.skills[0]
        }
        
        if number % 2 == 0 {
            skill = e.race.skills[0]
        }else {
            skill = e.race.skills[1]
        }
        
        return skill
    }
    
    private func generateRandomTargetAtk(players: [Player]) -> Player {
        
        let number = arc4random()
        
        var p: Player
        
        if players.count == 1 {
            return players[0]
        }
        
        if number % 2 == 0 {
            p = players[0]
        }else {
            p = players[1]
        }
        
        return p
    }
    
    //MARK: Animation Target
    private func applyAnimationTarget(target: SKSpriteNode) {
        
        let wiggleIn = SKAction.scaleXTo(1.0, duration: 0.2)
        let wiggleOut = SKAction.scaleXTo(1.2, duration: 0.2)
        let wiggle = SKAction.sequence([wiggleIn, wiggleOut, wiggleOut, wiggleIn])
        let wiggleRepeat = SKAction.repeatActionForever(wiggle)
        
        target.runAction(wiggleRepeat, withKey: "animationTarget")
    }
    
    private func disapplyAnimationTarget(target: SKSpriteNode) {
        
        target.removeActionForKey("animationTarget")
        
        let restoreAnimate = SKAction.scaleTo(1.5, duration: 0.2)
        target.runAction(restoreAnimate)
    }
    
    //MARK: Animation Skill
    private func applyAnimationSkill(skill: Skill) {
        
        let rotR = SKAction.rotateByAngle(0.05, duration: 0.2)
        let rotL = SKAction.rotateByAngle(-0.05, duration: 0.2)
        let cycle = SKAction.sequence([rotR, rotL, rotL, rotR])
        let wiggle = SKAction.repeatActionForever(cycle)
        
        skill.runAction(wiggle, withKey: "animatedSkill")
    }
    
    private func disapplyAnimationSkill(skill: Skill) {
        
        skill.removeActionForKey("animatedSkill")
        
        let restoreAngle = SKAction.rotateToAngle(0, duration: 0.1)
        skill.runAction(restoreAngle)
    }
    
    //MARK: Decrement MP using Skill
    private func decreaseMP(target: Player) {
        
        let footer = self.childNodeWithName("skFooter")!
        let bgBarMp = footer.childNodeWithName("bgBarStatusMp-\(target.race.name)")!
        
        let mpBar = bgBarMp.childNodeWithName("mpBar-\(target.race.name)")!
        mpBar.removeFromParent()
        
        let curr = (Int(mpBar.frame.size.width) * target.race.status.MP) / Int(bgBarMp.frame.size.width - 5)
        let currWidth = CGFloat((target.race.status.currentMP * Int(mpBar.frame.size.width)) / curr)
        
        let newMpBar = SKSpriteNode(color: UIColor(red: 0.1, green: 0.71, blue: 0.83, alpha: 1), size: CGSizeMake(currWidth, mpBar.frame.size.height))
        newMpBar.zPosition = mpBar.zPosition
        newMpBar.position = CGPointMake(mpBar.position.x - ((mpBar.frame.size.width - currWidth) / 2), mpBar.position.y)
        newMpBar.name = mpBar.name
        
        bgBarMp.addChild(newMpBar)
        
        let labelMp = bgBarMp.childNodeWithName("mpLabel-\(target.race.name)") as! SKLabelNode
        labelMp.removeFromParent()
        
        let newLabelMp = SKLabelNode(text: "\(target.race.status.currentMP)/\(target.race.status.MP)")
        newLabelMp.zPosition = labelMp.zPosition
        newLabelMp.position = labelMp.position
        newLabelMp.fontColor = labelMp.fontColor
        newLabelMp.fontName = labelMp.fontName
        newLabelMp.fontSize = labelMp.fontSize
        newLabelMp.name = labelMp.name
        
        bgBarMp.addChild(newLabelMp)
    }
    
    //MARK: Decrease HP from damage
    private func decreaseHP(target: Player) {
        let footer = self.childNodeWithName("skFooter")!
        let bgBar = footer.childNodeWithName("bgBarStatusHp-\(target.race.name)")!
        
        let hpBar = bgBar.childNodeWithName("hpBar-\(target.race.name)")!
        hpBar.removeFromParent()
        
        let curr = (Int(hpBar.frame.size.width) * target.race.status.HP) / Int(bgBar.frame.width - 5)
        
        let currWidth = CGFloat((target.race.status.currentHP * Int(hpBar.frame.size.width)) / curr)
        
        let newHpBar = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(currWidth, hpBar.frame.size.height))
        newHpBar.zPosition = hpBar.zPosition
        newHpBar.position = CGPointMake(hpBar.position.x - ((hpBar.frame.size.width - currWidth) / 2), hpBar.position.y)
        newHpBar.name = hpBar.name
        
        bgBar.addChild(newHpBar)
        
        let labelHp = bgBar.childNodeWithName("hpLabel-\(target.race.name)") as! SKLabelNode
        labelHp.removeFromParent()
        
        let newLabelHP = SKLabelNode(text: "\(target.race.status.currentHP)/\(target.race.status.HP)")
        newLabelHP.fontColor = labelHp.fontColor
        newLabelHP.fontSize = labelHp.fontSize
        newLabelHP.fontName = labelHp.fontName
        newLabelHP.name = labelHp.name
        newLabelHP.zPosition = labelHp.zPosition
        newLabelHP.position = labelHp.position
        
        bgBar.addChild(newLabelHP)
    }
    
    //MARK: Disable status player if is die
    private func disableStatusPlayer(target: Player) {
        
    }
    
    //MARK: Check Skills from MP
    private func checkSkills() {
        
        let skills = self.currentPlayer!.race.skills
        
        for s in skills {
            
            if s.baseSkill.consumeMana > self.currentPlayer!.race.status.currentMP {
                disableSkill(s)
            }
        }
    }
    
    //MARK: Enable and disable skill from combat
    private func enableSkill() {
        
        let footer = self.childNodeWithName("skFooter")!
        
        for var i = 0; i < 3; ++i {
            
            let disable = footer.childNodeWithName("disableSkill")
            
            if disable != nil {
                
                for child in footer.children {
                    
                    if (child is Skill) && (child.position.x == disable!.position.x && child.position.y == disable!.position.y) && (child as! Skill).baseSkill.consumeMana <= self.currentPlayer!.race.status.currentMP {
                        disable!.removeFromParent()
                        break
                    }
                }
            }else if i == 0 {
                break
            }
        }
    }
    
    private func disableSkill(skill: Skill) {
        
        let footer = self.childNodeWithName("skFooter")!
        
        let shadow = SKSpriteNode(color: UIColor.blackColor(), size: skill.size)
        shadow.zPosition = 20
        shadow.position = skill.position
        shadow.name = "disabelSkill"
        
        skill.addChild(shadow)
        
        //footer.addChild(shadow)
    }
}
