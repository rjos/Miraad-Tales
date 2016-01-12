//
//  MovementManagement.swift
//  MiraadTales
//
//  Created by Rodolfo José on 16/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class MovementManagement: SKNode {
    
    public var player: Player
    public let camera: SKCameraNode
    public var sizeMap: CGRect
    public let joystick: Joystick
    
    private let minPositionCamera: CGPoint
    private let maxPositionCamera: CGPoint
    
    private let minPositionPlayer: CGPoint
    private let maxPositionPlayer: CGPoint
    
    private let screenSize: UIScreen = UIScreen.mainScreen()
    
    public var players: [Player] = [Player]()
    private var isCameraStopped: Bool = false
    
    private var running: Bool
    
    public init(player: Player, camera: SKCameraNode, sizeMap: CGRect, joystick: Joystick, players: [Player]) {
        
        self.player = player
        self.player.alpha = 1
        self.player.zPosition += 2
        self.camera = camera
        self.sizeMap = sizeMap
        self.joystick = joystick
        self.running = false
        
        let min_X_camera = ((screenSize.bounds.width * camera.xScale) * 0.5)
        let min_Y_camera = ((screenSize.bounds.height * camera.yScale) * 0.5)
        
        //Menor posição que a camera pode movimentar
        self.minPositionCamera = CGPointMake(min_X_camera - (self.sizeMap.width * 0.5), min_Y_camera - (self.sizeMap.height * 0.5))
        //Mair posição que a camera pode movimentar
        self.maxPositionCamera = CGPointMake((self.sizeMap.width * 0.5) - min_X_camera, (self.sizeMap.height * 0.5) - min_Y_camera)
        
        let min_X_player = (player.size.width * 0.5) - (self.sizeMap.width * 0.5)
        let min_Y_player = (player.size.height * 0.5) - (self.sizeMap.height * 0.5)
        
        //Menor posição que o player pode movimentar
        self.minPositionPlayer = CGPointMake(min_X_player, min_Y_player)
        //Maior posição que o player pode movimentar
        self.maxPositionPlayer = CGPointMake((self.sizeMap.width * 0.5) - (player.size.width * 0.5), (self.sizeMap.height * 0.5) - (player.size.height * 0.5))
        
        self.players = players
        
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Update method
    public func update(currentTime: CFTimeInterval, didCollide:Bool) {
        
        self.player.update(currentTime)
        
        if !self.player.menuHasOpened && self.joystick.direction != DirectionPlayer.None && !didCollide {
            
            if self.players.count > 1 {
                if self.player.lastedPosition.count == 0 {
                    self.player.lastedPosition.append(self.player.position)
                }else {
                    self.player.lastedPosition.insert(self.player.position, atIndex: 0)
                }
            }
        }
        
        movePlayer(self.player, joystick: self.joystick, didCollide: didCollide)
        
        moveCamera(self.camera, player: self.player)
    }
    
    //MARK: - Move Camera and Players
    private func moveCamera(camera: SKCameraNode, player: Player) {
        
        //Atual posição da camera
        let lastedPositionCamera = camera.position
        
        //Verificando parametros de movimentação da camera
        if player.position.x >= self.minPositionCamera.x && player.position.x <= self.maxPositionCamera.x {
            camera.position.x = player.position.x
            self.isCameraStopped = false
        }
        
        if player.position.y >= self.minPositionCamera.y && player.position.y <= self.maxPositionCamera.y {
            camera.position.y = player.position.y
            self.isCameraStopped = false
        }
        
        //Verificar se não ocorreu movimentação na camera
        if camera.position.x == lastedPositionCamera.x && camera.position.y == lastedPositionCamera.y {
            self.isCameraStopped = true
        }
    }
    
    private func movePlayer(player: Player, joystick: Joystick, didCollide: Bool) {
        
        //Atual posição do players
        var lastedPositionPlayer = player.position
        
        //Velocidade para correr
        var velocityRunning = CGPointMake(0, 0)
        
        //Setar alpha pra 1
        player.alpha = 1
        
        lastedPositionPlayer = CGPointMake(lastedPositionPlayer.x + (joystick.velocity.x), lastedPositionPlayer.y + (joystick.velocity.y))
        if lastedPositionPlayer.x >= self.minPositionPlayer.x && lastedPositionPlayer.x <= self.maxPositionPlayer.x {
            
            //Incrementar velocidade X se estiver correndo
            if player.isRunning {
                
                if joystick.velocity.x < 0 {
                    velocityRunning.x = -0.5
                }else if joystick.velocity.x > 0{
                    velocityRunning.x = 0.5
                }
            }
            
            player.position.x = lastedPositionPlayer.x + velocityRunning.x
        }
        
        if lastedPositionPlayer.y >= self.minPositionPlayer.y && lastedPositionPlayer.y <= self.maxPositionPlayer.y {
            
            //Incrementar velocidade Y se estiver correndo
            if player.isRunning {
                
                if joystick.velocity.y < 0 {
                    velocityRunning.y = -0.5
                }else if joystick.velocity.y > 0 {
                    velocityRunning.y = 0.5
                }
            }
            
            player.position.y = lastedPositionPlayer.y + velocityRunning.y
        }
        
        //Verifica se a direção mudou
        if joystick.direction != player.lastedDirection {
            player.walkingPlayer(joystick.direction)
        }
        
        //Movimentar outros personagens se a direção for diferente de None ou se não tiver colisão
        if joystick.direction != DirectionPlayer.None && !didCollide {
            self.movimentOtherPlayers()
        }else if (joystick.direction == DirectionPlayer.None && self.player.lastedDirection == DirectionPlayer.None) || didCollide {
            self.removeActionsOtherPlayers()
        }
    }
    
    private func movimentOtherPlayers() {
        
        for (var i = 1; i < self.players.count; i++) {
            
            //Obter última posição do players principal
            let newPosition = self.players[i-1].lastedPosition.last!
            print(newPosition)
            //Incluir atual posição do player no vetor de posições
            self.players[i].lastedPosition.insert(self.players[i].position, atIndex: 0)
            
            //Obtendo direção para aplicar a animação de andar
            let direction = self.calculateDirection(self.players[i].position, newPosition: newPosition)
            
            //Se direção mudar, trocar a animação
            if direction != self.players[i].lastedDirection {
                self.players[i].walkingPlayer(direction)
            }
            
            //Setando nova posição
            self.players[i].position = newPosition
            
            //Removendo posição que andou do array do player principal
            self.players[i-1].lastedPosition.removeLast()
        }
    }
    
    private func removeActionsOtherPlayers() {
        
        for var i = 1; i < self.players.count; i++ {
            self.players[i].removeAction()
        }
    }
    
    //MARK: Switch players
    public func changePlayer(indexNewPlayer: Int) {
        
        //Trocar valor zPosition do current Player anterior a mudança
        self.player.zPosition -= 1
        
        //Selectionando novo player principal
        let newPlayer = self.players[indexNewPlayer]
        
        //Trocando posições do array
        let tempPlayer = self.players[0]
        tempPlayer.removePhysicsBodyPlayer()
        tempPlayer.alpha = 0.7
        
        self.players[0] = newPlayer
        self.players[indexNewPlayer] = tempPlayer
        
        self.player = newPlayer
        self.player.setPhysicsBodyPlayer(self.player.texture!)
        self.player.alpha = 1
        self.player.zPosition += 1
        
        //removendo antigas posições para recalcular futuramente
        self.player.lastedPosition.removeAll()
        
        //Validar posição dos personagens
        let X = tempPlayer.position.x - self.player.position.x
        let Y = tempPlayer.position.y - self.player.position.y
        
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
        
        //Mover a camera para a posição do novo player
        if !self.isCameraStopped {
            
            let move = SKAction.moveToX(self.player.position.x, duration: 0.1)
            
            //            let move = SKAction.moveTo(self.player.position, duration: 0.1)
            self.camera.runAction(move)
        }
    }
    
    //Function:
    private func calculateDirection(currentPosition: CGPoint, newPosition:CGPoint) -> DirectionPlayer {
        
        var direction: DirectionPlayer = DirectionPlayer.None
        
        //Obtendo vetor de direção
        let x = (Int(newPosition.x) - Int(currentPosition.x))
        let y = (Int(newPosition.y) - Int(currentPosition.y))
        
        if x == 0 /*Direção na Vertical*/ {
            
            if y > 0 {
                direction = DirectionPlayer.Up
            }else {
                direction = DirectionPlayer.Down
            }
            
        }else /*Direção na Horizontal*/ {
            
            if x > 0 {
                direction = DirectionPlayer.Right
            }else {
                direction = DirectionPlayer.Left
            }
        }
        
        return direction
    }
    
    public func addNewPlayer(p: Player) {
        self.players.append(p)
        
        //Validar posição dos personagens
        let X = p.position.x - self.player.position.x
        let Y = p.position.y - self.player.position.y
        
        //Movimentar na vertical
        if X > -30 && X < 30 {
            
            //Pra cima
            if Y < 0 {
                self.player.setLastedPosition(true, orientation: Orientation.Vertical)
            }else /*Pra baixo*/ {
                self.player.setLastedPosition(false, orientation: Orientation.Vertical)
            }
        }else /*Movimentar na horizontal*/ {
            
            //Pra direita
            if X < 0 {
                self.player.setLastedPosition(true, orientation: Orientation.Horizontal)
            }else /*Pra esquerda*/ {
                self.player.setLastedPosition(false, orientation: Orientation.Horizontal)
            }
        }
    }
}

public enum Orientation : String {
    
    case Vertical = "Vertical"
    case Horizontal = "Horizontal"
}
