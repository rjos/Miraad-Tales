//
//  MovementManagement.swift
//  MiraadTales
//
//  Created by Rodolfo José on 16/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class MovementManagement: SKNode {

    public var player: Player
    public let camera: SKCameraNode
    public var sizeMap: CGRect
    public let josytick: Joystick
    
    private let minPositionCamera: CGPoint
    private let maxPositionCamera: CGPoint
    
    private let minPositionPlayer: CGPoint
    private let maxPositionPlayer: CGPoint
    
    private let screenSize: UIScreen = UIScreen.mainScreen()
    
    public var players: [Player] = [Player]()
    private var isCameraStopped: Bool = false
    
    public init(player: Player, camera: SKCameraNode, sizeMap: CGRect, joystick: Joystick, players: [Player]) {
        
        self.player = player
        self.player.zPosition += 2
        self.camera = camera
        self.sizeMap = sizeMap
        self.josytick = joystick
        
        let min_X_camera = ((screenSize.bounds.width * camera.xScale) * 0.5)
        let min_Y_camera = ((screenSize.bounds.height * camera.yScale) * 0.5)
        
        self.minPositionCamera = CGPointMake(min_X_camera, min_Y_camera)
        self.maxPositionCamera = CGPointMake(self.sizeMap.width - min_X_camera, self.sizeMap.height - min_Y_camera)
        
        let min_X_player = player.size.width * 0.5
        let min_Y_player = player.size.height * 0.5
        
        self.minPositionPlayer = CGPointMake(min_X_player, min_Y_player)
        self.maxPositionPlayer = CGPointMake(self.sizeMap.width - min_X_player, self.sizeMap.height - min_Y_player)
        
        self.players = players
        
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update method
    public func update(currentTime: CFTimeInterval) {
        
        self.player.update(currentTime)
        
        if !self.player.menuHasOpened && self.josytick.direction != DirectionPlayer.None {
            
            if self.player.lastedPosition.count == 0 {
                self.player.lastedPosition.append(self.player.position)
            }else {
                self.player.lastedPosition.insert(self.player.position, atIndex: 0)
            }
            
            movePlayer(self.player, joystick: self.josytick)
        }
        
        moveCamera(self.camera, player: self.player)
    }
    
    //MARK: - Functions for move Camera and Players
    private func moveCamera(camera: SKCameraNode, player: Player) {
        
        let lastedPositionCamera = camera.position
        
        if player.position.x >= self.minPositionCamera.x && player.position.x <= self.maxPositionCamera.x {
            camera.position.x = player.position.x
            self.isCameraStopped = false
        }
        
        if player.position.y >= self.minPositionCamera.y && player.position.y <= self.maxPositionCamera.y {
            camera.position.y = player.position.y
            self.isCameraStopped = false
        }
        
        if camera.position.x == lastedPositionCamera.x && camera.position.y == lastedPositionCamera.y {
            self.isCameraStopped = true
        }
    }
    
    private func movePlayer(player: Player, joystick: Joystick) {
        
        var lastedPositionPlayer = player.position
        
        lastedPositionPlayer = CGPointMake(lastedPositionPlayer.x + (joystick.velocity.x), lastedPositionPlayer.y + (joystick.velocity.y))
        
        if lastedPositionPlayer.x >= self.minPositionPlayer.x && lastedPositionPlayer.x <= self.maxPositionPlayer.x {
            player.position.x = lastedPositionPlayer.x
        }
        
        if lastedPositionPlayer.y >= self.minPositionPlayer.y && lastedPositionPlayer.y <= self.maxPositionPlayer.y {
            player.position.y = lastedPositionPlayer.y
        }
        
        if joystick.direction != player.lastedDirection {
            player.walkingPlayer(josytick.direction)
        }
        
        self.movimentOtherPlayers()
    }
    
    private func movimentOtherPlayers() {
        
        for (var i = 1; i < self.players.count; i++) {
            
            let newPosition = self.players[i-1].lastedPosition.last!
            
            self.players[i].lastedPosition.insert(self.players[i].position, atIndex: 0)
            
            self.players[i].position = newPosition
            self.players[i-1].lastedPosition.removeLast()
        }
    }

    //MARK: -Function for switch between players
    public func changePlayer(indexNewPlayer: Int) {
        
        self.player.zPosition -= 2
        
        let newPlayer = self.players[indexNewPlayer]
        
        let tempPlayer = self.players[0]
        
        self.players[0] = newPlayer
        self.players[indexNewPlayer] = tempPlayer
        
        self.player = newPlayer
        self.player.zPosition += 2
        
        self.player.lastedPosition.removeAll()
        
        //Validar posição dos personagens
        let X = tempPlayer.position.x - self.player.position.x
        let Y = tempPlayer.position.y - self.player.position.y
        
        print(X)
        print(Y)
        
        //Movimentar na vertical
        if X > -30 && X < 30 {
            
            //Pra cima
            if Y < 0 {
                self.player.setLastedPosition(true, orientation: Orientation.Vertical)
            }else /*Pra baixo*/ {
                self.player.setLastedPosition(false, orientation: Orientation.Vertical)
            }
        }else if Y > -30 && Y < 30 /*Movimentar na horizontal*/ {
            
            //Pra direita
            if X < 0 {
                self.player.setLastedPosition(true, orientation: Orientation.Horizontal)
            }else /*Pra esquerda*/ {
                self.player.setLastedPosition(false, orientation: Orientation.Horizontal)
            }
        }
        
        //self.player.setLastedPosition(false)
        
        if !self.isCameraStopped {
            let move = SKAction.moveTo(self.player.position, duration: 0.1)
            self.camera.runAction(move)
        }
    }
    
}

public enum Orientation : String {
    
    case Vertical = "Vertical"
    case Horizontal = "Horizontal"
}
