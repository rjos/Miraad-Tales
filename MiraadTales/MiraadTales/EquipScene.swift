//
//  EquipScene.swift
//  MiraadTales
//
//  Created by Layon Tavares on 10/22/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class EquipScene: SKScene{
    
    var players = [Player]()
    var index:Int = 0
    var currentPlayer:Player! = nil
    
    public override func didMoveToView(view: SKView) {
        currentPlayer = players[index]
        // verificar quais equips estao unlocked para serem carregados
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            var equips = currentPlayer.race.equipments
            switch node.name!{
            case "weapon1":
                if(equips[0].unlocked){
                    // equip weapon 1
                }
                break
            case "weapon2":
                if(equips[0].unlocked){
                    // equip weapon 2
                }
                
                break
            case "weapon3":
                if(equips[0].unlocked){
                    // equip weapon 3
                }
                break
            case "equip1":
                if(equips[0].unlocked){
                    // equip armor 1
                }
                break
            case "equip2":
                if(equips[0].unlocked){
                    // equip armor 2
                }
                break
                
            case "equip3":
                if(equips[0].unlocked){
                    // equip armor 3
                }
                break
            
            default:
                break
                
            }
            if node.name == "equip1"{
                // change weapon
                for equip in currentPlayer.race.equipments{
                    if equip.unlocked{
                        
                    }
                }
            }else if node.name == "equip2"{
                // change armor
                
            }else if node.name == "rightArrow"{
                if(index < players.endIndex){
                    index++
                }else{
                    index = 0;
                }
                currentPlayer = players[index]
            }else if node.name == "leftArrow"{
                if(index > 0){
                    index--;
                }else{
                    index = players.endIndex
                }
                currentPlayer = players[index]
            }
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        <#code#>
    }
    
    public override func update(currentTime: NSTimeInterval) {
        <#code#>
    }
}



