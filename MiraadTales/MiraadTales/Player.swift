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

public class Player: SKSpriteNode, VLDContextSheetDelegate {
    
    public var race: BaseRace
    private var playerWalkingFrames = Array<Array<SKTexture>>()
    private let longTapPlayer: NSTimeInterval = 1.0
    private var touchStarted: NSTimeInterval? = nil
    private var contextMenuPlayer: VLDContextSheet? = nil
    private let viewController: UIView
    private var locationTouch: CGPoint? = nil
    
    public init(race: BaseRace, imageNamed: String, viewController: UIView) {
        self.race = race
        let texture = SKTexture(imageNamed: imageNamed)
        self.viewController = viewController
        super.init(texture: texture, color: UIColor.redColor(), size: texture.size())
        setAtlas()
        self.xScale = 0.5
        self.yScale = 0.5
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Get Atlas from animated walking
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
    
    //MARK: - Add and Remove action to wallking
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
    
    //MARK: - Event touches
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            touchStarted = touch.timestamp
            locationTouch = touch.locationInView(self.viewController)
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchStarted = nil
    }
    
    //MARK: - Update method
    public func update(currentTime: CFTimeInterval) {
        
        if touchStarted != nil && ((currentTime - touchStarted!) >= longTapPlayer) {
            
            touchStarted = nil
            if self.contextMenuPlayer == nil {
                self.creatingContextMenu()
            }
            
            self.openContextMenu()
        }
    }
    
    //MARK: - Creating and Opening Menu
    private func creatingContextMenu() {
        
        let item1 = VLDContextSheetItem(title: "Backpack", image: UIImage(named: "backpack"), highlightedImage: UIImage(named: "backpack"))
        
        let item2 = VLDContextSheetItem(title: "Diário", image: UIImage(named: "diario"), highlightedImage: UIImage(named: "diario"))
        
        let item3 = VLDContextSheetItem(title: "Inventário", image: UIImage(named: "inventorio"), highlightedImage: UIImage(named: "inventorio"))
        
        self.contextMenuPlayer = VLDContextSheet(items: [item1,item2,item3])
        self.contextMenuPlayer?.delegate = self
    }
    
    private func openContextMenu() {
        //let tapRecognizer = UITapGestureRecognizer(target: self.viewController, action: nil)
        self.contextMenuPlayer?.startWithGestureRecognizer(self.locationTouch!, inView: self.viewController)
    }
    
    public func contextSheet(contextSheet: VLDContextSheet!, didSelectItem item: VLDContextSheetItem!) {
        print(item.title)
        //Open menus!
    }
}
