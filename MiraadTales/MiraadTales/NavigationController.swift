//
//  NavigationController.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class NavigationController: SKView {
    
    private var scenes: [SKScene] = []
    
    public func Navigate(scene: SKScene) {
        
        self.scenes.append(scene)
        
        self.presentScene(scene)
    }
    
    public func Navigate(scene: SKScene, transition: SKTransition) {
        
        self.scenes.append(scene)
        
        self.presentScene(scene, transition: transition)
    }
    
    public func GoBack() {
        
        let currScene = self.scenes.removeLast()
        
        let lastScene = self.scenes.last!
        
        if currScene is CombatScene {
            lastScene.userData!["CombatScene"] = true
        }else {
            lastScene.userData!["CombatScene"] = false
        }
        
        lastScene.userData!["GoBack"] = true
        
        self.presentScene(lastScene)
        
    }
    
    public func GoBack(transition: SKTransition) {
        
        let currScene = self.scenes.removeLast()
        
        let lastScene = self.scenes.last!
        
        if currScene is CombatScene {
            lastScene.userData!["CombatScene"] = true
        }else {
            lastScene.userData!["CombatScene"] = false
        }
        
        lastScene.userData!["GoBack"] = true
        
        self.scene!.removeFromParent()
        
        self.presentScene(lastScene, transition: transition)
    }
}
