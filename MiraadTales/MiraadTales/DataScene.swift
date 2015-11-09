//
//  UserPreferences.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//
import UIKit
import Foundation
import SpriteKit

public class DataScene {
 
    private static var defaults: NSUserDefaults? = nil
    
    public static func SavaData(data: SKScene, key: String) {
        
        if defaults == nil {
            defaults = NSUserDefaults.standardUserDefaults()
        }
        
        let sceneEncoded = self.encodingSKScene(data)
        
        defaults!.setObject(sceneEncoded, forKey: key)
    }
    
    public static func LoadData(key: String) -> SKScene {
        
        if defaults == nil {
            defaults = NSUserDefaults.standardUserDefaults()
        }
        
        let data = defaults!.objectForKey(key) as! NSData
        
        let scene = self.decodingSKScene(data)
        
        return scene
    }
    
    private static func encodingSKScene(scene: SKScene) -> NSData {
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(scene)
        
        return data
    }
    
    private static func decodingSKScene(data: NSData) -> SKScene {
        
        var scene = SKScene()
        
        scene = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! SKScene
        
        return scene
    }
}
