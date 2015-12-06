//
//  DataController.swift
//  MiraadTales
//
//  Created by Rodolfo José on 06/12/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

public class DataController: NSObject {

    private static let defaults = NSUserDefaults.standardUserDefaults()
    
    public static func savaData(value: Bool, key: String) {
    
        defaults.setBool(value, forKey: key)
    }
    
    public static func loadData(key: String) -> Bool {
        return defaults.boolForKey(key)
    }
}
