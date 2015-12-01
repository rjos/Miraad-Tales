//
//  Player.swift
//  MiraadTales
//
//  Created by Rodolfo José on 08/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class Player: SKSpriteNode, VLDContextSheetDelegate {
    
    public var race: BaseRace
    public var lastedPosition = [CGPoint]()
    public var menuHasOpened: Bool = false
    public var inCombat: Bool
    public var inDialog: Bool
    public var lastedDirection: DirectionPlayer
    public var isRunning: Bool
    public var selectedMenuContext: String?
    public var usingItem: String? = nil
    
    private var itemsMenus: [VLDContextSheetItem] = []
    private var playerWalkingFrames = Array<Array<SKTexture>>()
    private var longTapPlayer: NSTimeInterval = 1.0
    private var touchStarted: NSTimeInterval? = nil
    private var contextMenuPlayer: VLDContextSheet? = nil
    private var viewController: UIView? = nil
    private var locationTouch: CGPoint? = nil
    
    var decoder = true
    
    
    public init(race: BaseRace, imageNamed: String, viewController: UIView?) {
        self.race = race
        let texture = SKTexture(imageNamed: imageNamed)
        self.viewController = viewController
        self.lastedDirection = DirectionPlayer.None
        self.inCombat = false
        self.inDialog = false
        self.isRunning = false
        self.selectedMenuContext = nil
        
        super.init(texture: texture, color: UIColor.redColor(), size: texture.size())
        
        self.name = self.race.name
        self.zPosition = 5
        
        //Filtro para não suavizar o pixel
        self.texture!.filteringMode = .Nearest
        
        //Set atlas animação do player
        setAtlas()
        
        //Set physics Body do player
        setPhysicsBodyPlayer(texture)
    }

    public func setPhysicsBodyPlayer(texture: SKTexture) {
        let size = texture.size()
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.collisionBitMask = CollisionSetUps.NPC.rawValue | CollisionSetUps.Items.rawValue | CollisionSetUps.Buildings.rawValue
        self.physicsBody?.categoryBitMask = CollisionSetUps.Player.rawValue
        self.physicsBody?.contactTestBitMask = CollisionSetUps.NPC.rawValue | CollisionSetUps.Items.rawValue | CollisionSetUps.Buildings.rawValue
        self.physicsBody?.allowsRotation = false
    }
    
    public func removePhysicsBodyPlayer() {
        self.physicsBody = nil
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    //MARK: - Get Atlas from animated walking
    private func setAtlas() {
        //Obtem atlas a partir do nome do player
        let playerAnimatedAtlas = SKTextureAtlas(named: self.race.name)
        var walkFrames = [SKTexture]()
        
        //Obtem a quantidade de frames no atlas
        let numImages = playerAnimatedAtlas.textureNames.count
        
        for var i = 0; i < numImages; i = i + 3 {
            //Adicionar os frames de acordo com cada direção da animação
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
        
        self.lastedDirection = direction
        
        let walkingFramesDirection: [SKTexture]
        
        switch direction {
        case .Up:
            walkingFramesDirection = self.playerWalkingFrames[3]
            break
        case .Down:
            walkingFramesDirection = self.playerWalkingFrames[0]
            break
        case .Left:
            walkingFramesDirection = self.playerWalkingFrames[1]
            break
        case .Right:
            walkingFramesDirection = self.playerWalkingFrames[2]
            break
        case .None:
            self.removeAction()
            walkingFramesDirection = []
            break
        }
        
        if direction != DirectionPlayer.None {
            self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkingFramesDirection, timePerFrame: 0.1, resize: false, restore: false)), withKey: "walkingINPlacePlayer\(self.name)")
        }
    }
    
    public func removeAction() {
        self.removeAllActions()
        self.lastedDirection = DirectionPlayer.None
    }
    
    //MARK: - Event touches
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.viewController == nil {
            return
        }
        
        if let touch = touches.first{
            
            touchStarted = touch.timestamp
            locationTouch = touch.locationInView(self.viewController)
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchStarted = nil
    }
    
    //MARK: - Update method
    public func update(currentTime: CFTimeInterval) {
        
        if (touchStarted != nil && ((currentTime - touchStarted!) >= longTapPlayer)) && self.viewController != nil {
            
            touchStarted = nil
            if self.contextMenuPlayer == nil {
                self.creatingContextMenu()
            }
            
            if !self.inCombat {
                self.openContextMenu()
            }
        }
    }
    
    //MARK: - Creating and Opening Menu
    private func creatingContextMenu() {
        
        let item = VLDContextSheetItem(title: "Inventário", image: UIImage(named: "inventorio"), highlightedImage: UIImage(named: "inventorio"))
        
        var contains = false
        
        for i in self.itemsMenus {
            
            if i.title == item.title {
                contains = true
                break
            }
        }
        
        if !contains && self.itemsMenus.count > 0 {
            self.itemsMenus.insert(item, atIndex: 0)
        }else if self.itemsMenus.count == 0 {
            self.itemsMenus.append(item)
        }
        
        self.contextMenuPlayer = VLDContextSheet(items: self.itemsMenus)
        self.contextMenuPlayer?.delegate = self
    }
    
    public func setItemIntoMenu(item: VLDContextSheetItem) {
        
        if !self.itemsMenus.contains(item) {
            self.itemsMenus.append(item)
        }
        
        creatingContextMenu()
    }
    
    private func openContextMenu() {
        self.contextMenuPlayer?.startWithGestureRecognizer(self.locationTouch!, inView: self.viewController)
        self.menuHasOpened = true
    }
    
    public func contextSheet(contextSheet: VLDContextSheet!, didSelectItem item: VLDContextSheetItem!) {
        print(item.title)
        
        //Open menus!
        self.selectedMenuContext = item.title
    }
    
    public func contextSheet(contextSheet: VLDContextSheet!) {
        
        self.menuHasOpened = false
    }
    
    //MARK: - Generate positions for walking other players
    public func setLastedPosition(positive: Bool, orientation: Orientation) {
        
        //Sinal de direção para calcular as posições entre a final e inicial
        var sign: CGFloat = -1
        
        if positive {
            sign = 1
        }
        
        //Posição final do player
        var targetPosition: CGFloat
        //Posição atual do player
        var current: CGFloat
        
        switch orientation {
        case .Horizontal:
            targetPosition = self.position.x - (self.frame.width * sign)
            current = self.position.x
            break
        case .Vertical:
            targetPosition = self.position.y - (self.frame.height * sign)
            current = self.position.y
            break
        }
        
        if positive {
            while Int(current) > Int(targetPosition) {
                switch orientation {
                case .Horizontal:
                    self.lastedPosition.append(CGPointMake(current, self.position.y))
                    break
                case .Vertical:
                    self.lastedPosition.append(CGPointMake(self.position.x, current))
                    break
                }
                
                current = current - (1.5 * sign)
            }
        }else {
            while Int(current) < Int(targetPosition) {
                switch orientation {
                case .Horizontal:
                    self.lastedPosition.append(CGPointMake(current, self.position.y))
                    break
                case .Vertical:
                    self.lastedPosition.append(CGPointMake(self.position.x, current))
                    break
                }
                
                current = current - (1.5 * sign)
            }
        }
    }
    
    //MARK: - Configure Combat and Exploration Scene
    public func setPlayerForCombat() {
        self.inCombat = true
        self.xScale = 1.5
        self.yScale = 1.5
        self.runAction(SKAction.animateWithTextures([self.playerWalkingFrames[2][1]], timePerFrame: 0.1, resize: false, restore: false), withKey: "Combat-\(self.race.name)")
    }
    
    public func setPlayerForExploration() {
        self.inCombat = false
        self.xScale = 1.0
        self.yScale = 1.0
        self.removeActionForKey("Combat-\(self.race.name)")
    }
}
