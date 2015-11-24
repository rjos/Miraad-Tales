//
//  Menu.swift
//  MiraadTales
//
//  Created by Rodolfo José on 29/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public enum TypeHUD: String {
    case Equip = "Equip"
    case Chapter = "Chapter"
    case Backpack = "Backpack"
}

public class HUD: SKNode {
    
    public var btnClose: SKSpriteNode
    public var bg: SKSpriteNode!
    public var bgTitle: SKSpriteNode
    public var players: [Player]
    public var currentPlayer: Player
    private let title: SKLabelNode
    
    public init(players: [Player], currentPlayer: Player, size: CGSize, name: String, typeHUD: TypeHUD) {
        
        self.players = players
        self.currentPlayer = currentPlayer
        
        if typeHUD == .Equip {
            self.bg = SKSpriteNode(imageNamed: "bgMenuEquipment")
        }else if typeHUD == .Chapter {
            self.bg = SKSpriteNode(imageNamed: "bgMenuEquipment")
        }else if typeHUD == .Backpack {
            self.bg = SKSpriteNode(imageNamed: "bgMenuEquipment")
        }
        
        bg.zPosition = 1
        bg.name = "bg"
        
        self.title = SKLabelNode(text: name)
        self.title.fontSize = 48
        self.title.fontName = "Prospero-Bold-NBP"
        self.title.fontColor = UIColor.whiteColor()
        self.title.position = CGPointMake(((self.bg.frame.width * 0.5) * 0.1), (self.title.frame.height * -0.5) + 5)
        self.title.zPosition = 3
        
        self.btnClose = SKSpriteNode(imageNamed: "closeButton")
        self.btnClose.name = "closeMenu"
        self.btnClose.zPosition = 3
        
        bgTitle = SKSpriteNode(imageNamed: "bgTitle")
        bgTitle.name = "bgTitle"
        bgTitle.position = CGPointMake(((bg.frame.width * -0.5) + (bgTitle.frame.width * 0.5)), ((bg.frame.height * 0.5) - (bgTitle.frame.height * 0.75)))
        bgTitle.zPosition = 2
        
        self.btnClose.position = CGPointMake((bgTitle.frame.width * -0.5) + (self.btnClose.frame.width * 0.5) + 10,0)
        
        let shadow = SKSpriteNode(color: UIColor.clearColor(), size: size)
        shadow.name = "shadow"
        shadow.alpha = 0.5
        shadow.zPosition = 1
        
        super.init()
        
        self.zPosition = 100
        
        //Add shadow open menu
        self.addChild(shadow)
        
        //add bg menu
        self.addChild(self.bg)
        
        self.bg.addChild(bgTitle)
        
        bgTitle.addChild(self.btnClose)
        bgTitle.addChild(self.title)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let nodeForPosition = self.nodeAtPoint(location)
            
            if nodeForPosition is SKSpriteNode && nodeForPosition.name == self.btnClose.name {
                //Close menu
                self.close()
            }
        }
    }
    
    public func open() {
        let actionScale = SKAction.scaleTo(1.0, duration: 0.2)
        self.runAction(actionScale) { () -> Void in
            //Inserir bluer de fundo
        }
    }
    
    public func close() {
        
        let actionScale = SKAction.scaleTo(0.01, duration: 0.2)
        self.runAction(actionScale) { () -> Void in
            //Remover bluer de fundo
            self.removeFromParent()
            
            for p in self.players {
                p.menuHasOpened = false
            }
        }
    }
}
