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
        
        if scenes.count > 0 {
            let lastScene = self.scenes.last!
            //DataScene.SavaData(lastScene, key: lastScene.name!)
        }
        
        self.scenes.append(scene)
        
        self.presentScene(scene)
    }
    
    public func Navigate(scene: SKScene, transition: SKTransition) {
        
        if scenes.count > 0 {
            let lastScene = self.scenes.last!
            //DataScene.SavaData(lastScene, key: lastScene.name!)
        }
        
        self.scenes.append(scene)
        
        self.presentScene(scene, transition: transition)
    }
    
    public func GoBack() {
        
        self.scenes.removeLast()
        
        let lastScene = self.scenes.last!
        
        //let scene = DataScene.LoadData(lastScene.name!)
        
        self.presentScene(lastScene)
        
    }
    
    public func GoBack(transition: SKTransition) {
        
        self.scenes.removeLast()
    }
}
