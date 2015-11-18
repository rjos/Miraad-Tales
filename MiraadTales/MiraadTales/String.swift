//
//  String.swift
//  MiraadTales
//
//  Created by Rodolfo José on 16/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}
