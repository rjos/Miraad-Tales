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
        
        if scene is Start {
            self.scenes.removeAll()
        }
        
        self.scenes.append(scene)
        
        self.presentScene(scene)
    }
    
    public func Navigate(scene: SKScene, transition: SKTransition) {
        
        if scene is Start {
            self.scenes.removeAll()
        }
        
        self.scenes.append(scene)
        
        self.presentScene(scene, transition: transition)
    }
    
    public func GoBack() {
        
        let currScene = self.scenes.removeLast()
        
        let lastScene = self.scenes.last!
        
        if currScene is CombatScene {
            lastScene.userData!["CombatScene"] = true
            lastScene.userData!["Win"] = (currScene as! CombatScene).win
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
            lastScene.userData!["Win"] = (currScene as! CombatScene).win
        }else {
            lastScene.userData!["CombatScene"] = false
        }
        
        lastScene.userData!["GoBack"] = true
        
        self.presentScene(lastScene, transition: transition)
    }
}
