//
//  SKScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/12/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

extension SKScene {
    
    func playAudio(name: String) {
        
        let audio = SKAudioNode(fileNamed: name)
        audio.autoplayLooped = true
        audio.name = "audio"
        self.addChild(audio)
    }
    
    func stopAudio() {
        
        let audio = self.childNodeWithName("audio")!
        audio.removeFromParent()
    }
    
    func changeVolume(volume: Float) {
        
        let audio = self.childNodeWithName("audio")!
        audio.runAction(SKAction.changeVolumeTo(volume, duration: 0.1))
    }
}
