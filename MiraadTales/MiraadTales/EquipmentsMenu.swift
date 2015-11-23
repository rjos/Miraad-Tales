//
//  EquipmentsMenu.swift
//  MiraadTales
//
//  Created by Rodolfo José on 29/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class EquipmentsMenu: HUD {
    
    private var widthItem: CGFloat = 0
    private var heightItem: CGFloat = 0
    
    private var selectedNodeAtk: Equip? = nil
    private var selectedNodeDef: Equip? = nil
    
    override init(players: [Player], currentPlayer: Player , size: CGSize, name: String, typeHUD: TypeHUD) {
        
        super.init(players: players, currentPlayer: currentPlayer ,size: size, name: name, typeHUD: typeHUD)
        
        let bgEquip = SKSpriteNode(imageNamed: "bgEquip")
        bgEquip.zPosition = 2
        bgEquip.name = "bgEquip"
        
        let tempWidth = self.bgTitle.frame.width - (self.bg.frame.width * 0.5)
        let tempPositionX = (self.bg.frame.width * 0.5) - tempWidth
        let posX = ((self.bg.frame.width * 0.5) - (bgEquip.frame.width * 0.5)) - tempPositionX
        
        bgEquip.position = CGPointMake(posX, (self.bgTitle.position.y - (bgEquip.frame.height * 0.5) - (self.bgTitle.frame.height * 0.5)))
        
        let bgStatus = SKSpriteNode(imageNamed: "bgStatus")
        bgStatus.name = "bgStatus"
        bgStatus.position = CGPointMake(0, (self.bg.frame.height * -0.5) + (bgStatus.frame.height * 0.5))
        bgStatus.zPosition = 2
        
        let bgEquips = SKSpriteNode(imageNamed: "bgEquips")
        bgEquips.name = "bgEquips"
        bgEquips.zPosition = -1
        
        self.bg.addChild(bgEquip)
        self.bg.addChild(bgStatus)
        
        bgEquip.addChild(bgEquips)
        
        let tempX = (bgEquip.frame.width * 0.5) - bgEquip.position.x
        let xPosition = ((bg.frame.width * -0.5) + tempX)
        
        let bgPlayer = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(xPosition * -1.0, bgEquip.frame.size.height))
        bgPlayer.name = "bgPlayer"
        
        let tempPosX = (bgPlayer.size.width * 0.5) - ((bgEquip.frame.size.width * 0.5) - bgEquip.position.x)
        
        bgPlayer.position = CGPointMake(xPosition - 1, bgEquip.position.y)
        bgPlayer.zPosition = 2
        
        self.bg.addChild(bgPlayer)
        
        self.setPlayer(self.currentPlayer)
        
        
        let indexPlayer = self.players.indexOf(self.currentPlayer)!
        
        if indexPlayer == 0 {
            self.disableButtons(false)
        }else if indexPlayer + 1 == self.players.count {
            self.disableButtons(true)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Touch events
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)

        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if node.name == "next" && node.alpha > 0.7 {
                self.changePlayer(true)
            }else if node.name == "preview" && node.alpha > 0.7 {
                self.changePlayer(false)
            }else if (node.name != nil && (node.name?.containsString("item-"))!) {
                
                if node.name == "item-0" || node.name == "item-1" || node.name == "item-2" {
                    //Mark Attack
                    self.selectedNodeAtk!.removeAllChildren()
                    let markAtk = SKSpriteNode(imageNamed: "markAtk")
                    node.addChild(markAtk)
                    self.selectedNodeAtk = (node as! Equip)
                }else {
                    //Mark defense
                    self.selectedNodeDef!.removeAllChildren()
                    let markDef = SKSpriteNode(imageNamed: "markDef")
                    node.addChild(markDef)
                    self.selectedNodeDef = (node as! Equip)
                }
                
                self.incrementStatus()
            }
        }
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    //MARK: Update Method
    public func update(currentTime: NSTimeInterval) {
        
    }
    
    //MARK: Set position player in equipment menu
    private func setPlayer(player: Player) {
        
        let bg = self.childNodeWithName("bg")!
        let bgPlayer = bg.childNodeWithName("bgPlayer")!
        
        bgPlayer.removeAllChildren()
        
        //Set Player width animations
        let currentPlayer = Player(race: player.race, imageNamed: "\(player.race.name)-2", viewController: nil)
        currentPlayer.xScale = 3
        currentPlayer.yScale = 3
        currentPlayer.position = CGPointMake(0, 0)
        currentPlayer.physicsBody = nil
        currentPlayer.zPosition = 3
        currentPlayer.walkingPlayer(DirectionPlayer.Down)
        
        bgPlayer.addChild(currentPlayer)
        
        //Next Button
        let nextPlayer = SKSpriteNode(imageNamed: "nextPlayer")
        nextPlayer.name = "next"
        
        //Preview Button
        let previewPlayer = SKSpriteNode(imageNamed: "nextPlayer")
        previewPlayer.name = "preview"
        previewPlayer.xScale = -1
        
        //Bg to interaction buttons of next and preview
        let bgNextPlayer = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake((bgPlayer.frame.size.width * 0.75), nextPlayer.size.height))
        bgNextPlayer.name = "bgInteraction"
        bgNextPlayer.position = CGPointMake(0, (bgPlayer.frame.size.height * -0.5) + (bgNextPlayer.size.height * 0.5))
        bgPlayer.addChild(bgNextPlayer)
        
        nextPlayer.position = CGPointMake((bgNextPlayer.size.width * 0.5) - (nextPlayer.size.width * 0.5),0)
        bgNextPlayer.addChild(nextPlayer)
        
        previewPlayer.position = CGPointMake((bgNextPlayer.size.width * -0.5) - (previewPlayer.size.width * 0.5), 0)
        bgNextPlayer.addChild(previewPlayer)
        
        //Set name current player
        let nameCurrentPlayer = SKLabelNode(text: "\(player.race.name)")
        nameCurrentPlayer.fontName = "Prospero-Bold-NBP"
        nameCurrentPlayer.fontSize = 30.0
        nameCurrentPlayer.fontColor = UIColor.whiteColor()
        nameCurrentPlayer.position = CGPointMake(0, (nameCurrentPlayer.frame.size.height * -0.5))
        
        bgNextPlayer.addChild(nameCurrentPlayer)
        
        self.setItemsEquips(player)
        self.setStatusPlayer(player)
    }
    
    //MARK: Set items equipment
    private func setItemsEquips(player: Player) {
        
        let bg = self.childNodeWithName("bg")!
        let bgEquip = bg.childNodeWithName("bgEquip")!
        
        let grid = bgEquip.childNodeWithName("bgEquips") as! SKSpriteNode
        
        grid.removeAllChildren()
        
        let gridPosition = self.setCollumsAndRows(grid, margin: CGPointMake(5,5), qtdadeCollums: 3, qtdadeRows: 2)
        
        var items:[SKSpriteNode] = []
        
        let hasItems = player.race.equipments.count > 0
        
        for var i = 0; i < 6; ++i {
            
            let item = SKSpriteNode(imageNamed: "equipBox")
            item.position = gridPosition[i]
            item.zPosition = 4
            
            if hasItems {
                //set items
                player.race.equipments[i].name = "item-\(i)"
                player.race.equipments[i].zPosition = item.zPosition + 1
                item.addChild(player.race.equipments[i])
                
                if player.race.equipments[i].baseEquip.isEquipped  &&  i < 3{
                    let markAttack = SKSpriteNode(imageNamed: "markAtk")
                    player.race.equipments[i].addChild(markAttack)
                    self.selectedNodeAtk = player.race.equipments[i]
                }else if player.race.equipments[i].baseEquip.isEquipped {
                    let markDefense = SKSpriteNode(imageNamed: "markDef")
                    player.race.equipments[i].addChild(markDefense)
                    self.selectedNodeDef = player.race.equipments[i]
                }
                
            }else {
                //Set shadow
            }
            
            grid.addChild(item)
        }
    }
    
    //MARK: Set status player
    private func setStatusPlayer(player: Player) {
        
        let bg = self.childNodeWithName("bg")!
        let bgStatus = bg.childNodeWithName("bgStatus") as! SKSpriteNode
        
        bgStatus.removeAllChildren()
        
        let gridPosition = self.setCollumsAndRows(bgStatus, margin: CGPointMake(60, 30), qtdadeCollums: 4, qtdadeRows: 2)
        
        let nameLevel = SKLabelNode(text: "Lv. ")
        nameLevel.fontColor = UIColor.whiteColor()
        nameLevel.fontSize = 30
        nameLevel.fontName = "Prospero-Bold-NBP"
        nameLevel.position = gridPosition[0]
        nameLevel.zPosition = bgStatus.zPosition + 1
        
        let numberLevel = SKLabelNode(text: "\(player.race.status.lvl)")
        numberLevel.fontColor = SKColor(red: 0.83, green: 0.46, blue: 0.21, alpha: 1)
        numberLevel.fontSize = 30
        numberLevel.fontName = "Prospero-Bold-NBP"
        numberLevel.position = CGPointMake(gridPosition[0].x + (nameLevel.frame.size.width * 0.5) + 10, gridPosition[0].y)
        numberLevel.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(nameLevel)
        bgStatus.addChild(numberLevel)
        
        let hp = SKLabelNode(text: "Hp \(player.race.status.HP)")
        hp.fontColor = UIColor.whiteColor()
        hp.fontSize = 30
        hp.fontName = "Prospero-Bold-NBP"
        hp.position = gridPosition[1]
        hp.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(hp)
        
        let mp = SKLabelNode(text: "Mp \(player.race.status.MP)")
        mp.fontColor = UIColor.whiteColor()
        mp.fontSize = 30
        mp.fontName = "Prospero-Bold-NBP"
        mp.position = CGPointMake(gridPosition[2].x - 10, gridPosition[2].y)
        mp.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(mp)
        
        let nameExp = SKLabelNode(text: "Exp.")
        nameExp.fontColor = UIColor.whiteColor()
        nameExp.fontSize = 30
        nameExp.fontName = "Prospero-Bold-NBP"
        nameExp.position = gridPosition[4]
        nameExp.zPosition = bgStatus.zPosition + 1
        
        let currentXP = SKLabelNode(text: "\(player.race.status.currentXP)")
        currentXP.fontColor = SKColor(red: 0.83, green: 0.46, blue: 0.21, alpha: 1)
        currentXP.fontSize = 30
        currentXP.fontName = "Prospero-Bold-NBP"
        currentXP.position = CGPointMake(gridPosition[4].x + (nameExp.frame.size.width * 0.5) + 10, gridPosition[4].y)
        currentXP.zPosition = bgStatus.zPosition + 1
        
        let totalXP = SKLabelNode(text: "/\(player.race.status.XP)")
        totalXP.fontColor = UIColor.whiteColor()
        totalXP.fontSize = 30
        totalXP.fontName = "Prospero-Bold-NBP"
        totalXP.position = CGPointMake(currentXP.position.x + (currentXP.frame.size.width * 0.5) + 10, gridPosition[4].y)
        totalXP.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(nameExp)
        bgStatus.addChild(currentXP)
        bgStatus.addChild(totalXP)
        
        let atk = SKLabelNode(text: "Atk \(player.race.status.pAtk + player.race.status.mAtk)")
        atk.fontColor = UIColor.whiteColor()
        atk.fontSize = 30
        atk.fontName = "Prospero-Bold-NBP"
        atk.position = gridPosition[5]
        atk.zPosition = bgStatus.zPosition + 1
        atk.name = "labelAtk"
        
        bgStatus.addChild(atk)
        
        let increaseAtk = SKLabelNode(text: "")
        increaseAtk.name = "increaseAtk"
        increaseAtk.fontColor = SKColor(red: 0.83, green: 0.46, blue: 0.21, alpha: 1)
        increaseAtk.fontSize = 30
        increaseAtk.fontName = "Prospero-Bold-NBP"
        increaseAtk.position = CGPointMake(atk.position.x + (atk.frame.size.width) - 5, atk.position.y)
        increaseAtk.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(increaseAtk)
        
        let def = SKLabelNode(text: "Def \(player.race.status.pDef + player.race.status.mDef)")
        def.fontColor = UIColor.whiteColor()
        def.fontSize = 30
        def.fontName = "Prospero-Bold-NBP"
        def.position = CGPointMake(gridPosition[6].x - 10, gridPosition[6].y)
        def.zPosition = bgStatus.zPosition + 1
        def.name = "labelDef"
        
        bgStatus.addChild(def)
        
        let increaseDef = SKLabelNode(text: "")
        increaseDef.name = "increaseDef"
        increaseDef.fontColor = SKColor(red: 0.83, green: 0.46, blue: 0.21, alpha: 1)
        increaseDef.fontSize = 30
        increaseDef.fontName = "Prospero-Bold-NBP"
        increaseDef.position = CGPointMake(def.position.x + (def.frame.size.width) - 5, def.position.y)
        increaseDef.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(increaseDef)
        
        let bgSkillAtk = SKSpriteNode(imageNamed: "bgAttackSkill")
        bgSkillAtk.position = CGPointMake(gridPosition[3].x - 10, gridPosition[3].y + (atk.frame.size.height * 0.5))
        bgSkillAtk.name = "bgSkillAtk"
        bgSkillAtk.zPosition = bgStatus.zPosition + 1
        
        let bgSkillDef = SKSpriteNode(imageNamed: "bgDefenseSkill")
        bgSkillDef.position = CGPointMake(gridPosition[7].x - 10, gridPosition[7].y + (def.frame.size.height * 0.5))
        bgSkillDef.name = "bgSkillDef"
        bgSkillDef.zPosition = bgStatus.zPosition + 1
        
        bgStatus.addChild(bgSkillAtk)
        bgStatus.addChild(bgSkillDef)
        
        //Increment Status from equipment
        self.incrementStatus()
    }
    
    //MARK: Generate grid position for items
    private func setCollumsAndRows(node: SKSpriteNode, margin: CGPoint, qtdadeCollums: CGFloat, qtdadeRows: CGFloat) -> [CGPoint] {
        
        let totalMarginX = margin.x * (qtdadeCollums + 1)
        let totalMarginY = margin.y * (qtdadeRows + 1)
        
        let tempWidth = node.frame.width - totalMarginX
        let tempHeight = node.frame.height - totalMarginY
        
        heightItem = tempHeight / qtdadeRows
        widthItem = tempWidth / qtdadeCollums
        
        var current = CGPointMake(-node.frame.width * 0.5, node.frame.height * 0.5)
        
        var positionsGrid: [CGPoint] = []
        
        for var i = 0; i < Int(qtdadeRows); ++i {
            
            for var j = 0; j < Int(qtdadeCollums); ++j {
                let positionItem = CGPointMake(current.x + (margin.x + (widthItem * 0.5)),current.y - (margin.y + ( heightItem * 0.5)))
                positionsGrid.append(positionItem)
                current.x += margin.x + (widthItem)
            }
            current.y -= margin.y + heightItem
            current.x = -node.frame.width * 0.5
        }
        
        return positionsGrid
    }
    
    
    //MARK: Change Player
    private func changePlayer(isNext: Bool) {
        
        let indexPlayer = self.players.indexOf(self.currentPlayer)!
        var increment: Int = 0
        
        if isNext {
            increment = 1
        }else {
            increment = -1
        }
        
        if (indexPlayer + increment) >= 0 && (indexPlayer + increment) < self.players.count {
            self.setPlayer(self.players[(indexPlayer + increment)])
            self.currentPlayer = self.players[indexPlayer + increment]
            
            if (indexPlayer + increment) == 0 || (indexPlayer + increment) == (self.players.count - 1) {
                disableButtons(isNext)
            }
        }
    }
    
    private func disableButtons(isNext: Bool) {
        
        let bgPlayer = self.bg.childNodeWithName("bgPlayer")!
        
        let bgInteraction = bgPlayer.childNodeWithName("bgInteraction")!
        
        let nextButton = bgInteraction.childNodeWithName("next")!
        let previewButton = bgInteraction.childNodeWithName("preview")!
        
        if isNext {
            nextButton.alpha = 0.7
            previewButton.alpha = 1.0
        }else{
            nextButton.alpha = 1.0
            previewButton.alpha = 0.7
        }
    }
    
    //MARK: Increment Status
    private func incrementStatus() {
        
        if self.selectedNodeAtk == nil && self.selectedNodeDef == nil {
            return
        }
        
        let bgStatus = self.bg.childNodeWithName("bgStatus")!
        
        let labelAtk = bgStatus.childNodeWithName("labelAtk")!
        let labelDef = bgStatus.childNodeWithName("labelDef")!
        
        let bgSkillAtk = bgStatus.childNodeWithName("bgSkillAtk")!
        bgSkillAtk.removeAllChildren()
        let bgSkillDef = bgStatus.childNodeWithName("bgSkillDef")!
        bgSkillDef.removeAllChildren()
        
        let increaseAtk = bgStatus.childNodeWithName("increaseAtk") as! SKLabelNode
        let increaseDef = bgStatus.childNodeWithName("increaseDef") as! SKLabelNode
        
        if self.selectedNodeAtk != nil {
            increaseAtk.text = "+ \(self.selectedNodeAtk!.baseEquip.status.pAtk + self.selectedNodeAtk!.baseEquip.status.mAtk)"
            
            let atkSkill = SKLabelNode(text: self.selectedNodeAtk!.baseEquip.name)
            atkSkill.fontColor = SKColor(red: 0.50, green: 0.10, blue: 0.06, alpha: 1)
            atkSkill.fontSize = 30
            atkSkill.fontName = "Prospero-Bold-NBP"
            atkSkill.zPosition = bgSkillAtk.zPosition + 1
            atkSkill.position = CGPointMake(0, -atkSkill.frame.size.height * 0.5)
            
            bgSkillAtk.addChild(atkSkill)
        }
        
        if self.selectedNodeDef != nil {
            increaseDef.text = "+ \(self.selectedNodeDef!.baseEquip.status.pDef + self.selectedNodeDef!.baseEquip.status.mDef)"
            
            let defSkill = SKLabelNode(text: self.selectedNodeAtk!.baseEquip.name)
            defSkill.fontColor = SKColor(red: 0.02, green: 0.20, blue: 0.49, alpha: 1)
            defSkill.fontSize = 30
            defSkill.fontName = "Prospero-Bold-NBP"
            defSkill.zPosition = bgSkillDef.zPosition + 1
            defSkill.position = CGPointMake(0, -defSkill.frame.size.height * 0.5)
            
            bgSkillDef.addChild(defSkill)
        }
    }
}
