//
//  BattleEnd.swift
//  MiraadTales
//
//  Created by Rodolfo José on 03/12/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public enum TypeBattleEnd: String {
    case Continue = "Continue"
    case TryAgain = "TryAgain"
    case CanBack  = "CanBack"
}

class BattleEnd: HUD {
    
    internal var typeBattleEnd: TypeBattleEnd!
    
    override init(players: [Player], currentPlayer: Player, size: CGSize, name: String, typeHUD: TypeHUD) {
        
        super.init(players: players, currentPlayer: currentPlayer, size: size, name: name, typeHUD: typeHUD)
        
        let content = SKSpriteNode(imageNamed: "headerChapter")
        content.zPosition = 1
        content.position = CGPointMake(0, (size.height / 2) - (content.frame.size.height / 2))
        
        self.bg!.addChild(content)
        
        let btnContinue = SKSpriteNode(imageNamed: "buttonBattleEnd")
        btnContinue.zPosition = 5
        btnContinue.name = "btnContinue"
        
        let labelBtnContine = SKLabelNode(text: "Continue")
        labelBtnContine.horizontalAlignmentMode = .Center
        labelBtnContine.verticalAlignmentMode = .Center
        labelBtnContine.fontColor = UIColor(red: 1, green: 0.98, blue: 0.76, alpha: 1)
        labelBtnContine.fontName = "Prospero-Bold-NBP"
        labelBtnContine.fontSize = 48
        labelBtnContine.zPosition = 1
        labelBtnContine.name = "btnContinueLabel-1"
        
        btnContinue.addChild(labelBtnContine)
        
        let btnTryAgain = SKSpriteNode(imageNamed: "buttonBattleEnd")
        btnTryAgain.zPosition = 5
        btnTryAgain.name = "btnTryAgain"
        
        let labelBtnTryAgain_1 = SKLabelNode(text: "Try")
        labelBtnTryAgain_1.horizontalAlignmentMode = .Center
        labelBtnTryAgain_1.verticalAlignmentMode = .Bottom
        labelBtnTryAgain_1.fontColor = UIColor(red: 1, green: 0.98, blue: 0.76, alpha: 1)
        labelBtnTryAgain_1.fontName = "Prospero-Bold-NBP"
        labelBtnTryAgain_1.fontSize = 48
        labelBtnTryAgain_1.zPosition = 1
        labelBtnTryAgain_1.name = "btnTryAgainLabel-1"
        
        let labelBtnTryAgain_2 = SKLabelNode(text: "Again")
        labelBtnTryAgain_2.horizontalAlignmentMode = .Center
        labelBtnTryAgain_2.verticalAlignmentMode = .Top
        labelBtnTryAgain_2.fontColor = UIColor(red: 1, green: 0.98, blue: 0.76, alpha: 1)
        labelBtnTryAgain_2.fontName = "Prospero-Bold-NBP"
        labelBtnTryAgain_2.fontSize = 48
        labelBtnTryAgain_2.zPosition = 1
        labelBtnTryAgain_2.name = "btnTryAgainLabel-2"
        
        btnTryAgain.addChild(labelBtnTryAgain_1)
        btnTryAgain.addChild(labelBtnTryAgain_2)
        
        let btnCanBack = SKSpriteNode(imageNamed: "buttonBattleEnd")
        btnCanBack.zPosition = 5
        btnCanBack.name = "btnCanBack"
        
        let labelBtnCanBack_1 = SKLabelNode(text: "Chapter")
        labelBtnCanBack_1.horizontalAlignmentMode = .Center
        labelBtnCanBack_1.verticalAlignmentMode = .Bottom
        labelBtnCanBack_1.fontColor = UIColor(red: 1, green: 0.98, blue: 0.76, alpha: 1)
        labelBtnCanBack_1.fontName = "Prospero-Bold-NBP"
        labelBtnCanBack_1.fontSize = 48
        labelBtnCanBack_1.zPosition = 1
        labelBtnCanBack_1.name = "btnCanBackLabel-1"
        
        let labelBtnCanBack_2 = SKLabelNode(text: "Selection")
        labelBtnCanBack_2.horizontalAlignmentMode = .Center
        labelBtnCanBack_2.verticalAlignmentMode = .Top
        labelBtnCanBack_2.fontColor = UIColor(red: 1, green: 0.98, blue: 0.76, alpha: 1)
        labelBtnCanBack_2.fontName = "Prospero-Bold-NBP"
        labelBtnCanBack_2.fontSize = 48
        labelBtnCanBack_2.zPosition = 1
        labelBtnCanBack_2.name = "btnCanBackLabel-2"
        
        btnCanBack.addChild(labelBtnCanBack_1)
        btnCanBack.addChild(labelBtnCanBack_2)
        
        if name == "You won!" {
            setPlayer(self.players, win: true)
            
            btnContinue.position = CGPointMake(0, (btnContinue.frame.height * 0.75) - (self.bg!.frame.height / 2))
            self.bg!.addChild(btnContinue)
        }else {
            setPlayer(self.players, win: false)
            
            btnTryAgain.position = CGPointMake(-(btnTryAgain.frame.width * 0.75), (btnTryAgain.frame.height * 0.75) - (self.bg!.frame.height / 2))
            btnCanBack.position = CGPointMake(btnCanBack.frame.width * 0.75, (btnCanBack.frame.height * 0.75) - (self.bg!.frame.height / 2))
            
            self.bg!.addChild(btnTryAgain)
            self.bg!.addChild(btnCanBack)
        }
        
    }

    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if node.name != nil {
                if node.name!.containsString("btnContinue") {
                    //continue
                    typeBattleEnd = TypeBattleEnd.Continue
                }else if node.name!.containsString("btnTryAgain") {
                    //lutar novamente
                    typeBattleEnd = TypeBattleEnd.TryAgain
                }else if node.name!.containsString("btnCanBack") {
                    //start
                    typeBattleEnd = TypeBattleEnd.CanBack
                }
            }
        }
    }
    
    private func setPlayer(players: [Player], win: Bool) {
        
        for var i = 0; i < players.count; ++i {
            
            var sufix: String = ""
            
            if win {
                sufix = "Jump"
            }else {
                sufix = "Cry"
            }
            
            let p = Player(race: players[i].race, imageNamed: "\(players[i].race.name)\(sufix)-1", viewController: nil)
            p.zPosition = 25
            p.xScale = 3
            p.yScale = 3
            
            if i == 0 {
                
                if players.count > 1 {
                    p.position = CGPointMake(-(p.frame.width), 0)
                }
            }else {
                p.position = CGPointMake((p.frame.width), 0)
            }
            
            self.bg!.addChild(p)
            animationPlayer(p, win: win, sufix: sufix)
        }
    }
    
    private func animationPlayer(player: Player, win: Bool, sufix: String) {
        
        let animationAtlas = SKTextureAtlas(named: "\(player.race.name)\(sufix)")
        let countTexture = animationAtlas.textureNames.count
        
        var textures: [SKTexture] = []
        
        for var i = 0; i < (countTexture / 2); ++i {
            let texture = animationAtlas.textureNamed("\(player.race.name)\(sufix)-\(i+1)")
            textures.append(texture)
        }
        
        let action = SKAction.animateWithTextures(textures, timePerFrame: 0.3, resize: false, restore: false)
        
        player.runAction(SKAction.repeatActionForever(action))
    }
}
