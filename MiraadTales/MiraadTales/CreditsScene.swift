//
//  CreditsScene.swift
//  MiraadTales
//
//  Created by Rodolfo José on 30/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let start = Start(fileNamed: "Start")!
        let transition = SKTransition.fadeWithDuration(1)
        
        (self.view as! NavigationController).Navigate(start, transition: transition)
    }
}
