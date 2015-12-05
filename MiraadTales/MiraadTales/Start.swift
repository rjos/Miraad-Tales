//
//  Start.swift
//  MiraadTales
//
//  Created by Rodolfo José on 23/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class Start: SKScene {

    // Sky
    var bgNode : SKSpriteNode!
    var bgNodeNext : SKSpriteNode!
    var logo: SKSpriteNode!
    var campfire: SKSpriteNode!
    var campfireAtlas: Array<SKTexture>! = []
    
    // Tap Button
    var labelButton: SKLabelNode!
    
    // Time of last frame
    var lastFrameTime : NSTimeInterval = 0
    
    // Time since last frame
    var deltaTime : NSTimeInterval = 0
    
    var chapters: ChapterMenu!
    var openChapters: Bool = false
    
    override func didMoveToView(view: SKView) {
        
        bgNode = self.childNodeWithName("SKStartBg") as! SKSpriteNode
        labelButton = bgNode.childNodeWithName("SKTapStart") as! SKLabelNode
        logo = bgNode.childNodeWithName("SKLogo") as! SKSpriteNode
        campfire = bgNode.childNodeWithName("SKCampFire") as! SKSpriteNode
        
        let hydora = bgNode.childNodeWithName("SKHydora") as! SKSpriteNode
        let rohan = bgNode.childNodeWithName("SKRohan") as! SKSpriteNode
        
        hydora.texture!.filteringMode = .Nearest
        rohan.texture!.filteringMode = .Nearest
        
        setAtlas()
        
        //Action logo
        let moveUpAction = SKAction.moveTo(CGPointMake(logo.position.x, logo.position.y + 10), duration: 2)
        let moveDownAction = SKAction.moveTo(CGPointMake(logo.position.x, logo.position.y - 10), duration: 2)
        
        let sequenceLogo = SKAction.sequence([moveUpAction, moveDownAction])
        
        self.logo.runAction(SKAction.repeatActionForever(sequenceLogo))
        
        //Action label
        let fadeInAction = SKAction.fadeAlphaTo(0, duration: 0.5)
        let fadeOutAction = SKAction.fadeAlphaTo(1, duration: 0.8)
        
        let sequenceLabel = SKAction.sequence([fadeInAction, fadeOutAction])
        
        self.labelButton.runAction(SKAction.repeatActionForever(sequenceLabel))
        
        //Action campfire
        let actionForever = SKAction.repeatActionForever(SKAction.animateWithTextures(self.campfireAtlas, timePerFrame: 0.5, resize: false, restore: false))
        
        self.campfire.runAction(actionForever, withKey: "actionCampfire")
    }
    
    //MARK: Touch Event's
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Open Menu Ep.
        
        if !openChapters {
            openChapters = true
            chapters = ChapterMenu(players: [], currentPlayer: DBPlayers.getBard(self.view!), size: self.size, name: "Chapter Selection", typeHUD: TypeHUD.Chapter)
            chapters.zPosition = 10
            chapters.xScale = 0.01
            chapters.yScale = 0.01
            
            bgNode.addChild(chapters)
            
            chapters.open()
        }
        
        if chapters != nil {
            chapters.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if chapters != nil {
            chapters.touchesEnded(touches, withEvent: event)
        }
    }
    
    //MARK: Parallax method
    func moveSprite(sprite : SKSpriteNode,
        nextSprite : SKSpriteNode, speed : Float) -> Void {
            var newPosition = CGPointZero
            
            // For both the sprite and its duplicate:
            for spriteToMove in [sprite, nextSprite] {
                
                // Shift the sprite leftward based on the speed
                newPosition = spriteToMove.position
                newPosition.x -= CGFloat(speed * Float(deltaTime))
                spriteToMove.position = newPosition
                
                // If this sprite is now offscreen (i.e., its rightmost edge is
                // farther left than the scene's leftmost edge):
                if spriteToMove.frame.maxX < self.frame.minX {
                    
                    // Shift it over so that it's now to the immediate right
                    // of the other sprite.
                    // This means that the two sprites are effectively
                    // leap-frogging each other as they both move.
                    spriteToMove.position =
                        CGPoint(x: spriteToMove.position.x +
                            spriteToMove.size.width * 2,
                            y: spriteToMove.position.y)
                }
                
            }
    }
    
    //MARK: Update Method
    override func update(currentTime: NSTimeInterval) {
        
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the four pairs of sprites.
        // Objects that should appear move slower than foreground objects.
        //self.moveSprite(bgNode!, nextSprite:bgNodeNext!, speed:25.0)
        
        if chapters != nil && chapters.isClosed {
            openChapters = false
            chapters = nil
        }else if chapters != nil && chapters.isOpenPage {
            let introScene = Intro(fileNamed: "Intro")
            let transition = SKTransition.fadeWithDuration(1)
            
            (self.view as! NavigationController).Navigate(introScene!, transition: transition)
        }
    }
    
    //MARK: - Get Atlas to animated
    private func setAtlas() {
        //Obtem atlas a partir do nome do player
        let atlasAnimated = SKTextureAtlas(named: "campfire")
        
        //Obtem a quantidade de frames no atlas
        let numImages = atlasAnimated.textureNames.count
        
        for var i = 0; i < numImages; ++i {
            
            let campfireTextureName = "campfire-\(i + 1)"
            campfireAtlas.append(atlasAnimated.textureNamed(campfireTextureName))
        }
    }
}
