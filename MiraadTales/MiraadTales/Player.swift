//
//  Player.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public enum DirectionPlayer: String {
    case Up = "DirectionUp"
    case Down = "DirectionDown"
    case Left = "DirectionLeft"
    case Right = "DirectionRight"
}

public class Player: SKNode {
    
    public let race: BaseRace
    private var sprite: SKSpriteNode
    private var playerWalkingFrames = Array<Array<SKTexture>>()
    
    public init(race: BaseRace, imageNamed: String) {
        self.race = race
        self.sprite = SKSpriteNode()
        super.init()
        self.setAtlas()
        self.sprite = SKSpriteNode(texture: self.playerWalkingFrames[0][1])
        self.addChild(self.sprite)
        self.xScale = 0.5
        self.yScale = 0.5
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(currentTime: CFTimeInterval) {
        
    }
    
    private func setAtlas() {
        let playerAnimatedAtlas = SKTextureAtlas(named: self.race.name)
        var walkFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        
        for var i = 0; i < numImages; i = i + 3 {
            for var j = 1; j <= 3; j++ {
                let playerTextureName = "\(self.race.name)\(i + j)"
                walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
            }
            
            self.playerWalkingFrames.append(walkFrames)
            walkFrames.removeAll()
        }
    }
    
    public func walkingPlayer(direction: DirectionPlayer) {
        
        self.removeAction()
        
        let walkingFramesDirection: [SKTexture]
        
        switch direction {
        case .Up:
            walkingFramesDirection = self.playerWalkingFrames[3]
            break
        case .Down:
            walkingFramesDirection = self.playerWalkingFrames[0]
            break
        case .Left:
            walkingFramesDirection = self.playerWalkingFrames[2]
            break
        case .Right:
            walkingFramesDirection = self.playerWalkingFrames[1]
            break
        }
        
        self.sprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkingFramesDirection, timePerFrame: 0.1, resize: false, restore: true)), withKey: "walkingINPlacePlayer\(self.name)")
    }
    
    public func removeAction() {
        self.sprite.removeAllActions()
    }
}
