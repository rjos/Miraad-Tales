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
        
        let playback = SKAction.playSoundFileNamed("\(name).mp3", waitForCompletion: false)
    }
    
    func stopAudio() {
        
        let audio = self.childNodeWithName("audio-\(self.name!)")!
        audio.removeFromParent()
    }
    
    func changeVolume(volume: Float) {
        
        let audio = self.childNodeWithName("audio-\(self.name)")!
        audio.runAction(SKAction.changeVolumeTo(volume, duration: 0.1))
    }
    
    func addEffect(name: String) {
        
        let effect = SKAudioNode(fileNamed: name)
        effect.name = "effect"
        
        self.addChild(effect)
    }
    
    func removeEffect() {
        
        let effect = self.childNodeWithName("effect")!
        effect.removeFromParent()
    }
}
