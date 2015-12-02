//
//  GameViewController.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright (c) 2015 Rodolfo José. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = MvpScene(fileNamed: "MvpScene") {
            // Configure the view.
            let skView = self.view as! NavigationController
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            
//            scene.typeCombat = "Normal"
//            let bard = DBPlayers.getBard(skView)
//            let equips = DBEquipSkill.getEquips(PlayersRace.Bard)
//            let skills = [DBEquipSkill.getSkill("Instrument Hit"), DBEquipSkill.getSkill("Power Chord"), DBEquipSkill.getSkill("Dark Sonata")]
//            bard.race.skills = skills
//            bard.race.equipments = equips
//            scene.players = [bard]
//            scene.enimies = DBEnemy.getEnemy("Zumbi", qtdade: 2)
            
            skView.showsPhysics = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set multi Touch */
            skView.multipleTouchEnabled = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.Navigate(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
