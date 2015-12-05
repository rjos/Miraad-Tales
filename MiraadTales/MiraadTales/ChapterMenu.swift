//
//  ChapterMenu.swift
//  MiraadTales
//
//  Created by Rodolfo José on 23/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class ChapterMenu: HUD {

    var isPrologue: Bool = false
    
    public var isOpenPage = false
    
    override init(players: [Player], currentPlayer: Player, size: CGSize, name: String, typeHUD: TypeHUD) {
        
        super.init(players: players, currentPlayer: currentPlayer, size: size, name: name, typeHUD: typeHUD)
        
        let content = SKSpriteNode(imageNamed: "headerChapter")
        content.zPosition = 1
        content.position = CGPointMake(0, (size.height / 2) - (content.frame.size.height / 2))
        
        self.bg!.addChild(content)
        
        let arrowLeft = SKSpriteNode(imageNamed: "arrowleftChapter")
        arrowLeft.zPosition = 5
        arrowLeft.alpha = 0.7
        arrowLeft.name = "arrowLeft"
        arrowLeft.position = CGPointMake(-(content.frame.width / 3) + (arrowLeft.frame.width / 2), 0)
        
        let arrowRight = SKSpriteNode(imageNamed: "arrowrightChapter")
        arrowRight.zPosition = 5
        arrowRight.name = "arrowRight"
        arrowRight.position = CGPointMake((content.frame.width / 3) - (arrowRight.frame.width / 2), 0)
        
        self.bg!.addChild(arrowLeft)
        self.bg!.addChild(arrowRight)
        
        let skNameSelected = SKLabelNode(text: "Prologue")
        skNameSelected.zPosition = 5
        skNameSelected.fontColor = UIColor.whiteColor()
        skNameSelected.fontSize = 48
        skNameSelected.fontName = "Prospero-Bold-NBP"
        skNameSelected.name = "labelChapter"
        skNameSelected.position = CGPointMake(0, -(self.bg!.frame.height / 2) + (skNameSelected.frame.height + 50))
        
        self.bg!.addChild(skNameSelected)
        
        let bookPrologue = SKSpriteNode(imageNamed: "bookprologue")
        bookPrologue.zPosition = 5
        bookPrologue.name = "book"
        bookPrologue.xScale = 0.8
        bookPrologue.yScale = 0.8
        
        self.bg!.addChild(bookPrologue)
        animationBook(bookPrologue)
        isPrologue = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            let node = self.nodeAtPoint(location)
            
            if (node is SKSpriteNode) && node.name == "arrowLeft" && !isPrologue {
                //esquerda
                node.alpha = 0.7
                let arrowRight = self.bg!.childNodeWithName("arrowRight")!
                arrowRight.alpha = 1.0
                
                changeBook(isPrologue)
                isPrologue = !isPrologue
            }else if (node is SKSpriteNode) && node.name == "arrowRight" && isPrologue {
                //direita
                node.alpha = 0.7
                let arrowLeft = self.bg!.childNodeWithName("arrowLeft")!
                arrowLeft.alpha = 1.0
                
                changeBook(isPrologue)
                isPrologue = !isPrologue
            }else if (node is SKSpriteNode) && node.name == "book" && isPrologue {
                self.isOpenPage = true
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
    }
    
    private func animationBook(book: SKSpriteNode) {
        
        let up = SKAction.moveToY(5, duration: 1)
        let down = SKAction.moveToY(-5, duration: 1)
        
        let sequence = SKAction.sequence([up, down, up, down, up])
        let action = SKAction.repeatActionForever(sequence)
        
        book.runAction(action)
    }
    
    private func changeBook(next: Bool) {
        
        var presentBook: SKSpriteNode
        var nextBook: SKSpriteNode
        
        var presentLabel: SKLabelNode
        var nextLabel: SKLabelNode
        
        presentBook = self.bg!.childNodeWithName("book") as! SKSpriteNode
        presentBook.removeFromParent()
        presentBook.removeAllActions()
        
        presentLabel = self.bg!.childNodeWithName("labelChapter") as! SKLabelNode
        presentLabel.removeFromParent()
        
        if next {
            nextBook = SKSpriteNode(imageNamed: "booksoon")
            nextLabel = SKLabelNode(text: "Chapter 1 (Coming Soon)")
        }else {
            nextBook = SKSpriteNode(imageNamed: "bookprologue")
            nextLabel = SKLabelNode(text: "Prologue")
        }
        
        nextLabel.name = presentLabel.name
        nextLabel.fontColor = presentLabel.fontColor
        nextLabel.fontName = presentLabel.fontName
        nextLabel.fontSize = presentLabel.fontSize
        nextLabel.zPosition = presentLabel.zPosition
        nextLabel.position = presentLabel.position
        
        self.bg!.addChild(nextLabel)
        
        nextBook.name = presentBook.name
        nextBook.position = presentBook.position
        nextBook.zPosition = presentBook.zPosition
        nextBook.xScale = presentBook.xScale
        nextBook.yScale = presentBook.yScale
        
        self.bg!.addChild(nextBook)
        animationBook(nextBook)
    }
}
