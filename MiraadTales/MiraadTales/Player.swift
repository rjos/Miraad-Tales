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

public class Player: SKSpriteNode {
    
    public var race: BaseRace
    private var playerWalkingFrames = Array<Array<SKTexture>>()
    private let longTapPlayer: NSTimeInterval = 1.0
    private var touchStarted: NSTimeInterval? = nil
    
    public init(race: BaseRace, imageNamed: String) {
        self.race = race
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.redColor(), size: texture.size())
        setAtlas()
        self.xScale = 0.5
        self.yScale = 0.5
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            touchStarted = touch.timestamp
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchStarted = nil
    }
    
    public func update(currentTime: CFTimeInterval) {
        
        if touchStarted != nil && ((currentTime - touchStarted!) >= longTapPlayer) {
            
            touchStarted = nil
            print("Open menu")
        }
    }
    
    private func setAtlas() {
        let playerAnimatedAtlas = SKTextureAtlas(named: self.race.name)
        var walkFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        
        for var i = 0; i < numImages; i = i + 3 {
            for var j = 1; j <= 3; j++ {
                let playerTextureName = "\(self.race.name)-\(i + j)"
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
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkingFramesDirection, timePerFrame: 0.1, resize: false, restore: true)), withKey: "walkingINPlacePlayer\(self.name)")
    }
    
    public func removeAction() {
        self.removeAllActions()
    }
}
