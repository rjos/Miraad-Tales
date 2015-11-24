//
//  PositionManagement.swift
//  MiraadTales
//
//  Created by Rodolfo José on 24/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class PositionManagement {
    
    private var positionPlayer: Array<CGPoint> = []
    private var positionCamera: CGPoint = CGPointZero
    
    public func setPosition(players: [Player]) {
        
        positionPlayer.removeAll()
        
        for p in players {
            positionPlayer.append(p.position)
        }
    }
    
    public func getPositionPlayer() -> Array<CGPoint> {
        return positionPlayer
    }
    
    public func setPosition(camera: SKCameraNode) {
        positionCamera = camera.position
    }
    
    public func getPositionCamera() -> CGPoint {
        return positionCamera
    }
}
