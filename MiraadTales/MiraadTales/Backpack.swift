//
//  Backpack.swift
//  MiraadTales
//
//  Created by Rodolfo José on 03/12/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

public class Backpack {
    
    private static var items: [Item] = []
    
    public static func addItem(item: Item) {
        items.append(item)
    }
    
    public static func hasItem(name: String) -> Bool {
        
        var has: Bool = false
        
        for var i = 0; i < items.count && !has; ++i {
            if items[i].item.name == name {
                has = true
            }
        }
        
        return has
    }
}
